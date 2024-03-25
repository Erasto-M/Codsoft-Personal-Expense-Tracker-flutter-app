import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_expense_tracker_codsoft/Authentication/Providers/auth_providers.dart';
import 'package:personal_expense_tracker_codsoft/Authentication/Screens/loading_screen.dart';
import 'package:personal_expense_tracker_codsoft/Authentication/Screens/login_screen.dart';
import 'package:personal_expense_tracker_codsoft/Authentication/auth_checker.dart';
import 'package:personal_expense_tracker_codsoft/Authentication/Screens/signup_screen.dart';
import 'package:personal_expense_tracker_codsoft/Home/homepage.dart';

// main function using riverpod provider scope  and
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final initializeFirebase = ref.watch(initializeFirebaseProvider);
    return MaterialApp(
      home: initializeFirebase.when(
        data: (data) => const AuthChecker(),
        error: (e, stackTrace) {
          return Text("$e".toString());
        },
        loading: () => const LoadingScreen(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
