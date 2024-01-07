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

@TypedGoRoute<NavRoute>(
  path: '/home',
)


class NavRoute extends GoRouteData {
  const NavRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return MaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: const BottomNavigationBar(),
    );
  }
}

class BottomNavigationBar extends StatefulWidget {
  const BottomNavigationBar({super.key});

  @override
  State<BottomNavigationBar> createState() => _BottomNavigationBarState();
}

class _BottomNavigationBarState extends State<BottomNavigationBar> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentPageIndex,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.feed),
            icon: Icon(Icons.feed_outlined),
            label: 'Feed',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.groups),
            icon: Icon(Icons.groups_outlined),
            label: 'Clubs',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.notifications),
            icon: Icon(Icons.notifications_outlined),
            label: 'Updates',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.person),
            icon: Icon(Icons.person_outlined),
            label: 'Profile',
          ),
        ],
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('User is Authenticated'),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

