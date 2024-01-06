import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:institute_app/application/auth/auth_bloc.dart';
import 'package:institute_app/domain/auth/models/auth_failure.dart';
import 'package:institute_app/presentation/pages/auth/widgets/madeby_text.dart';
import 'package:institute_app/presentation/pages/auth/widgets/sign_in_button.dart';
import 'package:institute_app/presentation/pages/auth/widgets/sign_in_text.dart';
import 'package:institute_app/presentation/widgets/logo.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthenticationFailed) {
          showFlushbar(context, state.failure);
        }
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).canvasColor,
        body: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: size.height,
            ),
            child: SafeArea(
              child: SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildLogo(size),
                    buildTitle(size),
                    buildSignIn(size),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildLogo(Size size) {
    return Hero(
      tag: 'logo',
      child: SizedBox(
        height: size.height * 0.3,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: AppLogo(
            size: size.height * 0.24,
          ),
        ),
      ),
    );
  }

  Widget buildTitle(Size size) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          const Text(
            'Institute App',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Text(
            'IIT Mandi',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: size.height * 0.2),
        ],
      ),
    );
  }

  Widget buildSignIn(Size size) {
    return SizedBox(
      width: size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const SignInText(),
          SignInButton(size),
          const MadeByText(),
        ],
      ),
    );
  }

  void showFlushbar(BuildContext context, AuthFailure failure) {
    Flushbar<void>(
      backgroundColor: Theme.of(context).colorScheme.errorContainer,
      borderRadius: BorderRadius.circular(8),
      duration: const Duration(seconds: 3),
      messageColor: Theme.of(context).colorScheme.onErrorContainer,
      animationDuration: const Duration(milliseconds: 500),
      icon: Icon(
        Icons.error_outline,
        color: Theme.of(context).colorScheme.onErrorContainer,
      ),
      title: 'Sign In failed',
      titleColor: Theme.of(context).colorScheme.onErrorContainer,
      margin: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 32,
      ),
      messageText: Text(
        failure.map(
          cancelledByUser: (_) => 'Cancelled by user',
          serverError: (_) => 'Server error',
          nonInstituteEmail: (_) => 'Non institute email',
          accountExistsWithDifferentCredential: (_) =>
              'Account exists with different credential',
          invalidCredential: (_) => 'Invalid credential',
          userDisabled: (_) => 'User disabled',
        ),
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
      ),
    ).show(context);
  }
}
