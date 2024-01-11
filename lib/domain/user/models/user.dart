import 'package:fpdart/fpdart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:institute_app/domain/auth/models/auth_user.dart';
import 'package:institute_app/domain/core/failures.dart';
import 'package:institute_app/domain/core/value_objects.dart';
import 'package:institute_app/domain/user/models/value_objects.dart';

part 'user.freezed.dart';

@freezed
abstract class User with _$User {
  const factory User({
    required UniqueId id,
    required StringSingleLine name,
    required EmailAddress emailAddress,
    required DateTime createdAt,
    required DateTime updatedAt,
    Url? photoUrl,
    UserBio? bio,
  }) = _User;

  factory User.empty() => User(
        id: UniqueId(),
        name: StringSingleLine(' '),
        emailAddress: EmailAddress('email@iitmandi.ac.in'),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

  factory User.fromAuthUser(AuthUser authUser) {
    return User(
      id: authUser.id,
      name: authUser.name,
      emailAddress: authUser.email,
      photoUrl: authUser.photoUrl,
      bio: UserBio.empty(),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }
}

extension UserX on User {
  Option<ValueFailure<dynamic>> get failureOption {
    return name.failureOrUnit
        .andThen(() => emailAddress.failureOrUnit)
        .fold(
          some,
          (_) => none(),
        );
  }
}
