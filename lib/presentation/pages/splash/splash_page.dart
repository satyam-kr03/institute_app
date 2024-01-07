import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:institute_app/application/auth/auth_bloc.dart';
import 'package:institute_app/presentation/routes/router.dart';
import 'package:institute_app/presentation/widgets/logo.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        state.maybeMap(
          authenticated: (_) {
            Future.delayed(
              const Duration(milliseconds: 200),
                  () =>
                  context.pushReplacement(const NavRoute().location),
            );
          },
          unauthenticated: (_) {
            Future.delayed(
              const Duration(milliseconds: 200),
              () =>
                  context.pushReplacement(const LoginRoute().location),
            );
          },
          orElse: () {},
        );
      },
      child: const Scaffold(
        body: Center(
          child: AppLogo(),
        ),
      ),
    );
  }
}
