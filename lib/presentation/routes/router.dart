import 'dart:async';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:institute_app/application/auth/auth_bloc.dart';
import 'package:institute_app/presentation/pages/auth/login_page.dart';
import 'package:institute_app/presentation/pages/splash/splash_page.dart';

part 'router.g.dart';

const initialLocation = '/';

final router = GoRouter(
  routes: $appRoutes,
  debugLogDiagnostics: kDebugMode,
  initialLocation: initialLocation,
  redirect: (context, state) {
    log('redirect: ${state.matchedLocation}');
    final authState = context.read<AuthBloc>().state;
    if (authState is! Authenticated) {
      if (state.matchedLocation == const SplashRoute().location) {
        return null;
      }
      if (state.matchedLocation != const LoginRoute().location) {
        return const LoginRoute().location;
      }
    }
    return null;
  },
);

@TypedGoRoute<SplashRoute>(
  path: initialLocation,
)
class SplashRoute extends GoRouteData {
  const SplashRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const SplashPage();
}

@TypedGoRoute<LoginRoute>(
  path: '/login',
)
class LoginRoute extends GoRouteData {
  const LoginRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const LoginPage();
}
