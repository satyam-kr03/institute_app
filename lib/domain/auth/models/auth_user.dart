import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_user.freezed.dart';
part 'auth_user.g.dart';

@freezed
abstract class AuthUser with _$AuthUser {
  @Assert(
    'email.endsWith("iitmandi.ac.in")',
    'Email must be of IIT Mandi',
  )
  factory AuthUser({
    required String id,
    required String name,
    required String email,
    String? photoUrl,
  }) = _AuthUser;

  factory AuthUser.fromJson(Map<String, Object?> json) =>
      _$AuthUserFromJson(json);
}
