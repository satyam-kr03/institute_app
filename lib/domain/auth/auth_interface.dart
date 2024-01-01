import 'package:fpdart/fpdart.dart';
import 'package:institute_app/domain/auth/models/auth_failure.dart';
import 'package:institute_app/domain/auth/models/auth_user.dart';

abstract class AuthInterface {
  Option<AuthUser> getSignedInUser();
  Future<void> signOut();
  Future<Either<AuthFailure, AuthUser>> signInWithGoogle();
}
