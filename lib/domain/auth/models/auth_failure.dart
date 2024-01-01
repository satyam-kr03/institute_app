import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_failure.freezed.dart';

@freezed
sealed class AuthFailure with _$AuthFailure {
  const factory AuthFailure.cancelledByUser() = CancelledByUser;
  const factory AuthFailure.serverError() = ServerError;
  const factory AuthFailure.nonInstituteEmail() = NonInstituteEmail;
  const factory AuthFailure.accountExistsWithDifferentCredential() =
      AccountExistsWithDifferentCredential;
  const factory AuthFailure.invalidCredential() = InvalidCredential;
  const factory AuthFailure.userDisabled() = UserDisabled;
}
