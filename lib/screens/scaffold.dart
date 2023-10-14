import 'package:adaptive_navigation/adaptive_navigation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

enum ScaffoldTab {
  products,
  profile,
}

class AppScaffold extends StatelessWidget {
  /// Creates a [AppScaffold].
  const AppScaffold({
    required this.selectedTab,
    required this.child,
    super.key,
  });

  /// Which tab of the scaffold to display.
  final ScaffoldTab selectedTab;

  /// The scaffold body.
  final Widget child;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: AdaptiveNavigationScaffold(
          appBar: AppBar(
            title: const Text(
              'DummyMart',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          selectedIndex: selectedTab.index,
          body: child,
          onDestinationSelected: (int idx) {
            switch (ScaffoldTab.values[idx]) {
              case ScaffoldTab.products:
                context.go('/products');
              case ScaffoldTab.profile:
                context.go('/profile');
            }
          },
          destinations: const <AdaptiveScaffoldDestination>[
            AdaptiveScaffoldDestination(
              title: 'Products',
              icon: Icons.shopping_basket_sharp,
            ),
            AdaptiveScaffoldDestination(
              title: 'Profile',
              icon: Icons.person,
            ),
          ],
        ),
      );
}
