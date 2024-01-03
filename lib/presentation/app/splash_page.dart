import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:institute_app/application/auth/auth_bloc.dart';
import 'package:institute_app/domain/auth/models/auth_failure.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        switch (state) {
          case Initial _:
            log('Initial');
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Initial'),
              ),
            );
          case Authenticating _:
            log('Authenticating');
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Authenticating'),
              ),
            );
          case Authenticated(:final user):
            log('Authenticated ${user.name}');
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Authenticated'),
              ),
            );
          case Unauthenticated _:
            log('Unauthenticated');
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Unauthenticated'),
              ),
            );
          case AuthenticationFailed(:final failure):
            log('Authentication Failed $failure');

            switch (failure) {
              case CancelledByUser():
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Cancelled By User'),
                  ),
                );
              case ServerError():
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Server Error'),
                  ),
                );
              case NonInstituteEmail():
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Non Institute Email Error'),
                  ),
                );
              case AccountExistsWithDifferentCredential _:
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Account Exists With Different Credential',
                    ),
                  ),
                );
              case InvalidCredential():
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Invalid Credential'),
                  ),
                );
              case UserDisabled():
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('User Disabled'),
                  ),
                );
            }
        }
      },
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: ElevatedButton(
                onPressed: () => BlocProvider.of<AuthBloc>(context)
                    .add(const AuthEvent.signInWithGoogleRequested()),
                child: const Text('Sign In With Google'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
