import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:institute_app/domain/core/failures.dart';
import 'package:institute_app/domain/core/value_objects.dart';

part 'auth_user.freezed.dart';

@freezed
abstract class AuthUser with _$AuthUser {
  factory AuthUser({
    required UniqueId id,
    required StringSingleLine name,
    required EmailAddress email,
    String? photoUrl,
  }) = _AuthUser;
}

extension AuthUserX on AuthUser {
  Option<ValueFailure<dynamic>> get failureOption {
    return name.failureOrUnit.andThen(() => email.failureOrUnit).fold(
          some,
          (r) => const None(),
        );
  }
}
