import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../services.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoggedIn = ref.watch(isLoggedInProvider);
    final user = ref.watch(currentUserProvider);

    void logout() {
      ref.read(currentUserProvider.notifier).logout();

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Logged out'),
        ));
      }
    }

    return isLoggedIn
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (user != null) ...[
                Text(
                  'Logged in as ${user.fullName}.',
                  textAlign: TextAlign.center,
                ),
                const Gap(8),
              ],
              Center(
                child: FilledButton(
                  onPressed: logout,
                  child: const Text('Logout'),
                ),
              ),
            ],
          )
        : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'You are not logged in.',
                textAlign: TextAlign.center,
              ),
              const Gap(8),
              Center(
                child: FilledButton(
                  onPressed: () => context.go('/login'),
                  child: const Text('Login'),
                ),
              ),
            ],
          );
  }
}
