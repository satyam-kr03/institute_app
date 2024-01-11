import 'package:fpdart/fpdart.dart';
import 'package:institute_app/domain/core/value_objects.dart';
import 'package:institute_app/domain/user/models/user.dart';
import 'package:institute_app/domain/user/models/user_failure.dart';

abstract class UserRepositoryInterface {
  Future<Option<User>> getCurrentUser();
  Future<Either<UserFailure, Unit>> createUser(User user);
  Future<Either<UserFailure, Unit>> updateUser(User user);
  Future<Either<UserFailure, Unit>> deleteUser(UniqueId id);
  Future<Option<User>> getInitialUserFromAuth();
  Future<Either<UserFailure, User>> getUserFromId(UniqueId id);
}
