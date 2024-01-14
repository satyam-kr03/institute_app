import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ShellRouteWidget extends StatelessWidget {
  const ShellRouteWidget({
    required this.child,
    super.key,
  });

  final Widget child;

  int getCurrentIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    switch (location) {
      case '/home':
        return 0;
      default:
        return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = getCurrentIndex(context);
    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        destinations: const <Widget>[
          NavigationDestination(
            label: 'Home',
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
          ),
          NavigationDestination(
            label: 'Explore',
            icon: Icon(Icons.search_outlined),
            selectedIcon: Icon(Icons.search),
          ),
          NavigationDestination(
            label: 'Updates',
            icon: Icon(Icons.notifications_outlined),
            selectedIcon: Icon(Icons.notifications),
          ),
        ],
        onDestinationSelected: (value) {
          switch (value) {
            case 0:
              GoRouter.of(context).go('/home');
            case 1:
              GoRouter.of(context).go('/explore');
            case 2:
              GoRouter.of(context).go('/updates');
          }
        },
      ),
    );
  }
}
