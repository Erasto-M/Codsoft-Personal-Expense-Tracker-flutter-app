import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_expense_tracker_codsoft/Widgets/reusable_widgets.dart';

class SignUpScreen extends ConsumerWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              showBigText(text: "Sign Up ", fontWeight: FontWeight.bold),
              showmediumspace(),
              mediumBigText(
                  text: "Create account to get things done",
                  fontWeight: FontWeight.w200),
              showLargespace(),
            ],
          ),
        ),
      ),
    );
  }
}
