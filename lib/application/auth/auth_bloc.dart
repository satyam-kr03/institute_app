import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:institute_app/domain/auth/auth_interface.dart';
import 'package:institute_app/domain/auth/models/auth_failure.dart';
import 'package:institute_app/domain/auth/models/auth_user.dart';

part 'auth_event.dart';
part 'auth_state.dart';
part 'auth_bloc.freezed.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({required AuthInterface authInterface})
      : _authInterface = authInterface,
        super(
          authInterface.getSignedInUser().fold(
                () => const AuthState.unauthenticated(),
                AuthState.authenticated,
              ),
        ) {
    on<AuthEvent>((events, emit) async {
      switch (events) {
        case AuthCheckRequested _:
          final userOption = _authInterface.getSignedInUser();
          emit(
            userOption.fold(
              () => const AuthState.unauthenticated(),
              AuthState.authenticated,
            ),
          );
        case SignInWithGoogleRequested _:
          emit(const AuthState.authenticating());
          final failureOrSuccess = await _authInterface.signInWithGoogle();
          emit(
            failureOrSuccess.fold(
              AuthState.authenticationFailed,
              AuthState.authenticated,
            ),
          );
        case SignedOut _:
          await _authInterface.signOut();
          emit(const AuthState.unauthenticated());
      }
    });
  }

  final AuthInterface _authInterface;
}
