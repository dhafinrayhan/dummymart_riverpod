import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'screens/login.dart';
import 'screens/product_details.dart';
import 'screens/products.dart';
import 'screens/profile.dart';
import 'screens/scaffold.dart';

void main() {
  HttpOverrides.global = AppHttpOverrides();

  runApp(ProviderScope(child: DummyMartApp()));
}

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
        path: '/login',
        redirect: (_, __) => '/profile/login',
      ),
      GoRoute(
        path: '/product/:productId',
        redirect: (BuildContext context, GoRouterState state) =>
            '/products/${state.pathParameters['productId']}',
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
        routes: <GoRoute>[
          GoRoute(
            path: ':productId',
            builder: (BuildContext context, GoRouterState state) {
              final productId = int.parse(state.pathParameters['productId']!);
              return ProductDetailsScreen(id: productId);
            },
          ),
        ],
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
        routes: <GoRoute>[
          GoRoute(
            path: 'login',
            builder: (BuildContext context, GoRouterState state) =>
                const LoginScreen(),
          ),
        ],
      ),
    ],
    debugLogDiagnostics: true,
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      theme: ThemeData(
        useMaterial3: true,
        textTheme: GoogleFonts.montserratTextTheme(Theme.of(context).textTheme),
      ),
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
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation.drive(_curveTween),
            child: child,
          ),
        );

  static final CurveTween _curveTween = CurveTween(curve: Curves.easeIn);
}

class AppHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (_, __, ___) => true;
  }
}
