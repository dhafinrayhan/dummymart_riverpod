import 'package:dio/dio.dart';
import 'package:flextras/flextras.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../services.dart';

class LoginScreen extends HookConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usernameController = useTextEditingController();
    final passwordController = useTextEditingController();

    final isLoading = useState(false);

    Future<void> login() async {
      isLoading.value = true;
      try {
        await ref.read(currentUserProvider.notifier).login(
              username: usernameController.text,
              password: passwordController.text,
            );

        if (context.mounted) {
          context.go('/');
        }
      } on DioException catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(e.response?.data?['message'] ?? 'Login failed'),
          ));
        }
      } finally {
        isLoading.value = false;
      }
    }

    return Scaffold(
      appBar: AppBar(),
      body: PaddedColumn(
        padding: const EdgeInsets.all(24),
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Login',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          const Gap(12),
          Card(
            elevation: 0,
            color: Theme.of(context).colorScheme.surfaceVariant,
            child: PaddedColumn(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              children: [
                const Text(
                  'Use these sample credentials:',
                ),
                const Gap(4),
                Text(
                  'username: umcgourty9\npassword: i0xzpX',
                  style: GoogleFonts.firaMono(fontSize: 12),
                ),
              ],
            ),
          ),
          const Gap(12),
          TextField(
            controller: usernameController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Username',
            ),
            textInputAction: TextInputAction.next,
          ),
          const Gap(12),
          TextField(
            controller: passwordController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Password',
            ),
            obscureText: true,
            keyboardType: TextInputType.visiblePassword,
            textInputAction: TextInputAction.done,
          ),
          const Gap(32),
          FilledButton(
            onPressed: login,
            style: ButtonStyle(
              minimumSize: MaterialStateProperty.all(const Size.fromHeight(48)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (isLoading.value) ...[
                  const SizedBox(
                    width: 10,
                    height: 10,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  ),
                  const Gap(12),
                ],
                const Text('Login'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
