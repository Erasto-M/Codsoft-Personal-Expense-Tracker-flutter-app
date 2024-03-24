// this class checks whether the user is logged in or not using the provider created in the auth_providers.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_expense_tracker_codsoft/Authentication/Providers/auth_providers.dart';
import 'package:personal_expense_tracker_codsoft/Authentication/Screens/login_screen.dart';
import 'package:personal_expense_tracker_codsoft/Authentication/Screens/loading_screen.dart';
import 'package:personal_expense_tracker_codsoft/Home/homepage.dart';

class AuthChecker extends ConsumerWidget {
  const AuthChecker({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authStateChecker = ref.watch(userAuthStateProvider);
    return authStateChecker.when(
        data: (data) {
          if (data != null) {
            return const HomePage();
          } else {
            return const LoginScreen();
          }
        },
        error: (e, stackTrace) {
          return Text('$e'.toString());
        },
        loading: () => const LoadingScreen());
  }
}
