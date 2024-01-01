part of 'auth_bloc.dart';

@freezed
sealed class AuthEvent with _$AuthEvent {
  const factory AuthEvent.authCheckRequested() = AuthCheckRequested;
  const factory AuthEvent.signInWithGoogleRequested() =
      SignInWithGoogleRequested;
  const factory AuthEvent.signedOut() = SignedOut;
}
