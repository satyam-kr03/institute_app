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

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorAKey = GlobalKey<NavigatorState>(debugLabel: 'shellA');
final _shellNavigatorBKey = GlobalKey<NavigatorState>(debugLabel: 'shellB');
final _shellNavigatorCKey = GlobalKey<NavigatorState>(debugLabel: 'shellC');
final _shellNavigatorDKey = GlobalKey<NavigatorState>(debugLabel: 'shellD');
final _shellNavigatorEKey = GlobalKey<NavigatorState>(debugLabel: 'shellE');

class ScaffoldWithNestedNavigation extends StatelessWidget {
  const ScaffoldWithNestedNavigation({
    Key? key,
    required this.navigationShell,
  }) : super(key: key ?? const ValueKey('ScaffoldWithNestedNavigation'));
  final StatefulNavigationShell navigationShell;

  void _goBranch(int index) {
    navigationShell.goBranch(
      index,
      // A common pattern when using bottom navigation bars is to support
      // navigating to the initial location when tapping the item that is
      // already active. This example demonstrates how to support this behavior,
      // using the initialLocation parameter of goBranch.
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        destinations: const <Widget>[
          NavigationDestination(label: 'Home', icon: Icon(Icons.home_outlined), selectedIcon:Icon(Icons.home)),
          NavigationDestination(label: 'Feed', icon: Icon(Icons.feed_outlined), selectedIcon: Icon(Icons.feed),),
          NavigationDestination(label: 'Clubs', icon: Icon(Icons.groups_outlined), selectedIcon: Icon(Icons.groups)),
          NavigationDestination(label: 'Updates', icon: Icon(Icons.notifications_outlined), selectedIcon: Icon(Icons.notifications)),
          NavigationDestination(label: 'Profile', icon: Icon(Icons.person_outlined), selectedIcon: Icon(Icons.person) ),
        ],
        onDestinationSelected: _goBranch,
      ),
    );
  }
}

class RootScreen extends StatelessWidget {
  const RootScreen({
    super.key,
    required this.label,
    required this.detailsPath,
  });

  final String label;
  final String detailsPath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(label),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('This is the root screen for $label'),
            ElevatedButton(
              onPressed: () => context.go(detailsPath),
              child: const Text('Go to details'),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key, required this.label}) : super(key: key);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details for $label'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('This is the details screen for $label'),
          ],
        ),
      ),
    );
  }
}

final router = GoRouter(
  routes: [
    $splashRoute,
    $loginRoute,
    $navRoute,
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        // the UI shell
        return ScaffoldWithNestedNavigation(
            navigationShell: navigationShell,);
      },
      branches: [
        // first branch (A)
        StatefulShellBranch(
          navigatorKey: _shellNavigatorAKey,
          routes: [
            // top route inside branch
            GoRoute(
              path: '/a',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: RootScreen(label: 'Home', detailsPath: '/a/details'),
              ),
              routes: [
                // child route
                GoRoute(
                  path: 'details',
                  builder: (context, state) =>
                  const DetailsScreen(label: 'Home'),
                ),
              ],
            ),
          ],
        ),
        // second branch (B)
        StatefulShellBranch(
          navigatorKey: _shellNavigatorBKey,
          routes: [
            // top route inside branch
            GoRoute(
              path: '/b',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: RootScreen(label: 'Feed', detailsPath: '/b/details'),
              ),
              routes: [
                // child route
                GoRoute(
                  path: 'details',
                  builder: (context, state) =>
                  const DetailsScreen(label: 'Feed'),
                ),
              ],
            ),
          ],
        ),
        // third branch (C)
        StatefulShellBranch(
          navigatorKey: _shellNavigatorCKey,
          routes: [
            // top route inside branch
            GoRoute(
              path: '/c',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: RootScreen(label: 'Clubs', detailsPath: '/c/details'),
              ),
              routes: [
                // child route
                GoRoute(
                  path: 'details',
                  builder: (context, state) =>
                  const DetailsScreen(label: 'Clubs'),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorDKey,
          routes: [
            // top route inside branch
            GoRoute(
              path: '/d',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: RootScreen(label: 'Updates', detailsPath: '/d/details'),
              ),
              routes: [
                // child route
                GoRoute(
                  path: 'details',
                  builder: (context, state) =>
                  const DetailsScreen(label: 'Updates'),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorEKey,
          routes: [
            // top route inside branch
            GoRoute(
              path: '/e',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: RootScreen(label: 'Profile', detailsPath: '/e/details'),
              ),
              routes: [
                // child route
                GoRoute(
                  path: 'details',
                  builder: (context, state) =>
                  const DetailsScreen(label: 'Profile'),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
  debugLogDiagnostics: kDebugMode,
  initialLocation: initialLocation,
  navigatorKey: _rootNavigatorKey,

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

