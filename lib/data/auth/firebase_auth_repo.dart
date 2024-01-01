import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:institute_app/domain/auth/auth_interface.dart';
import 'package:institute_app/domain/auth/models/auth_failure.dart';
import 'package:institute_app/domain/auth/models/auth_user.dart';

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
    final user = _firebaseAuth.currentUser;
    return user != null
        ? some(
            AuthUser(
              id: user.uid,
              name: user.displayName ?? '',
              email: user.email ?? '',
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
      if (credential.user != null) {
        if (credential.user!.email!.endsWith('iitmandi.ac.in')) {
          return right(
            AuthUser(
              id: credential.user!.uid,
              name: credential.user!.displayName ?? '',
              email: credential.user!.email ?? '',
            ),
          );
        } else {
          await credential.user!.delete();
          await _googleSignIn.signOut();
          await _firebaseAuth.signOut();
          return left(const AuthFailure.nonInstituteEmail());
        }
      } else {
        return left(const AuthFailure.serverError());
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        return left(
          const AuthFailure.accountExistsWithDifferentCredential(),
        );
      } else if (e.code == 'invalid-credential') {
        return left(const AuthFailure.invalidCredential());
      } else {
        return left(const AuthFailure.serverError());
      }
    } on PlatformException catch (e) {
      if (e.code == 'ERROR_USER_DISABLED') {
        return left(const AuthFailure.userDisabled());
      } else {
        return left(const AuthFailure.serverError());
      }
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
