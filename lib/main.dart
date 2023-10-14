import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'screens/products.dart';
import 'screens/profile.dart';
import 'screens/scaffold.dart';

void main() => runApp(ProviderScope(child: DummyMartApp()));

class DummyMartApp extends StatelessWidget {
  DummyMartApp({super.key});

  final ValueKey<String> _scaffoldKey = const ValueKey<String>('appScaffold');

  late final GoRouter _router = GoRouter(
    routes: <GoRoute>[
      GoRoute(
        path: '/',
        redirect: (_, __) => '/products',
      ),
      GoRoute(
        path: '/products',
        pageBuilder: (BuildContext context, GoRouterState state) =>
            FadeTransitionPage(
          key: _scaffoldKey,
          child: const AppScaffold(
            selectedTab: ScaffoldTab.products,
            child: ProductsScreen(),
          ),
        ),
      ),
      GoRoute(
        path: '/profile',
        pageBuilder: (BuildContext context, GoRouterState state) =>
            FadeTransitionPage(
          key: _scaffoldKey,
          child: const AppScaffold(
            selectedTab: ScaffoldTab.profile,
            child: ProfileScreen(),
          ),
        ),
      ),
    ],
    debugLogDiagnostics: true,
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      theme: ThemeData(useMaterial3: true),
    );
  }
}

/// A page that fades in and out.
class FadeTransitionPage extends CustomTransitionPage<void> {
  /// Creates a [FadeTransitionPage].
  FadeTransitionPage({
    required LocalKey super.key,
    required super.child,
  }) : super(
            transitionsBuilder: (BuildContext context,
                    Animation<double> animation,
                    Animation<double> secondaryAnimation,
                    Widget child) =>
                FadeTransition(
                  opacity: animation.drive(_curveTween),
                  child: child,
                ));

  static final CurveTween _curveTween = CurveTween(curve: Curves.easeIn);
}
