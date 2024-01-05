import 'package:auth_buttons/auth_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:institute_app/application/auth/auth_bloc.dart';

class SignInButton extends StatelessWidget {
  const SignInButton(this.size, {super.key});
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 32,
        vertical: 16,
      ),
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return GoogleAuthButton(
            onPressed: () {
              if (state is! Authenticating) {
                context.read<AuthBloc>().add(
                      const AuthEvent.signInWithGoogleRequested(),
                    );
              }
            },
            isLoading: state is Authenticating,
            style: AuthButtonStyle(
              elevation: 4,
              width: size.width - 64,
              height: 48,
              progressIndicatorValueColor:
                  Theme.of(context).colorScheme.onPrimary,
              progressIndicatorColor:
                  Theme.of(context).colorScheme.primary,
              borderRadius: 16,
              visualDensity: VisualDensity.standard,
            ),
          );
        },
      ),
    );
  }
}
