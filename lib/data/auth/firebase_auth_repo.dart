import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:institute_app/domain/auth/auth_interface.dart';
import 'package:institute_app/domain/auth/models/auth_failure.dart';
import 'package:institute_app/domain/auth/models/auth_user.dart';
import 'package:institute_app/domain/core/value_objects.dart';

@LazySingleton(as: AuthInterface)
class FirebaseAuthRepo implements AuthInterface {
  FirebaseAuthRepo({
    required FirebaseAuth firebaseAuth,
    required GoogleSignIn googleSignIn,
  })  : _firebaseAuth = firebaseAuth,
        _googleSignIn = googleSignIn;

  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  @override
  Option<AuthUser> getSignedInUser() {
    return _firebaseAuth.currentUser != null
        ? some(
            AuthUser(
              id: UniqueId.fromUniqueString(
                _firebaseAuth.currentUser!.uid,
              ),
              name: StringSingleLine(
                _firebaseAuth.currentUser!.displayName!,
              ),
              email: EmailAddress(_firebaseAuth.currentUser!.email!),
            ),
          )
        : none();
  }

  @override
  Future<Either<AuthFailure, AuthUser>> signInWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return left(const AuthFailure.cancelledByUser());
      }

      final googleAuthentication = await googleUser.authentication;
      final authCredential = GoogleAuthProvider.credential(
        accessToken: googleAuthentication.accessToken,
        idToken: googleAuthentication.idToken,
      );

      final credential =
          await _firebaseAuth.signInWithCredential(authCredential);
      final user = credential.user;
      if (user == null) {
        return left(const AuthFailure.serverError());
      }

      final authUser = AuthUser(
        id: UniqueId.fromUniqueString(user.uid),
        name: StringSingleLine(user.displayName!),
        email: EmailAddress(user.email!),
      );

      return authUser.failureOption.fold(
        () => right(authUser),
        (failure) => failure.maybeMap(
          nonInstituteEmail: (_) {
            user.delete();
            signOut();
            return left(const AuthFailure.nonInstituteEmail());
          },
          orElse: () => left(const AuthFailure.serverError()),
        ),
      );
    } on FirebaseAuthException catch (e) {
      return left(_handleFirebaseAuthException(e));
    } on PlatformException catch (e) {
      return left(_handlePlatformException(e));
    }
  }

  AuthFailure _handleFirebaseAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'account-exists-with-different-credential':
        return const AuthFailure.accountExistsWithDifferentCredential();
      case 'invalid-credential':
        return const AuthFailure.invalidCredential();
      default:
        return const AuthFailure.serverError();
    }
  }

  AuthFailure _handlePlatformException(PlatformException e) {
    if (e.code == 'ERROR_USER_DISABLED') {
      return const AuthFailure.userDisabled();
    } else {
      return const AuthFailure.serverError();
    }
  }

  @override
  Future<void> signOut() {
    return Future.wait([
      _googleSignIn.signOut(),
      _firebaseAuth.signOut(),
    ]);
  }
}
