import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_expense_tracker_codsoft/Authentication/Providers/auth_providers.dart';
import 'package:personal_expense_tracker_codsoft/Authentication/Screens/login_screen.dart';
import 'package:personal_expense_tracker_codsoft/Widgets/reusable_widgets.dart';

class SignUpScreen extends ConsumerWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    // Controllers
    final emailController = ref.watch(emailControllerProvider);
    final usernameController = ref.watch(userNameControllerProvider);
    final passwordController = ref.watch(passWordControllerProvider);
    final confirmPasswordController =
        ref.watch(confirmPasswordControllerProvider);

    // isLoading
    final isLoading = ref.watch(isLoadingProvider);

    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              showLargespace(),
              showLargespace(),
              showBigText(text: "Sign Up ", fontWeight: FontWeight.bold),
              showmediumspace(),
              mediumText(
                  text: "Create account to get things done",
                  fontWeight: FontWeight.w200),
              showLargespace(),
              showLargespace(),
              showLargespace(),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    showTextFormField(
                      controller: usernameController,
                      labelText: "UserName",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "UserName field cannot be empty";
                        }
                        return null;
                      },
                      prefixIcon: Icons.person_2_outlined,
                      suffixIcon: null,
                      textInputType: TextInputType.name,
                      obscureText: false,
                    ),
                    showmediumspace(),
                    showTextFormField(
                      controller: emailController,
                      labelText: "Email",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email field cannot be empty';
                        } else if (!value.contains('@gmail.com')) {
                          return "Please enter a valid email address";
                        }
                        return null;
                      },
                      prefixIcon: Icons.email,
                      suffixIcon: null,
                      textInputType: TextInputType.emailAddress,
                      obscureText: false,
                    ),
                    showmediumspace(),
                    showTextFormField(
                      controller: passwordController,
                      labelText: "Password",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Password field cannot be empty";
                        } else if (value.length < 6) {
                          return "Password must be at least 6 characters long";
                        }
                        return null;
                      },
                      prefixIcon: Icons.lock,
                      suffixIcon: Icons.visibility_off,
                      textInputType: TextInputType.text,
                      obscureText: true,
                    ),
                    showmediumspace(),
                    showTextFormField(
                      controller: confirmPasswordController,
                      labelText: "Confirm Password",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Confirm Password field cannot be empty";
                        } else if (value != passwordController.text) {
                          return "Passwords do not match";
                        }
                        return null;
                      },
                      prefixIcon: Icons.lock,
                      suffixIcon: Icons.visibility_off,
                      textInputType: TextInputType.text,
                      obscureText: true,
                    ),

                    // create account button
                    showLargespace(),
                    isLoading
                        ? const CircularProgressIndicator()
                        : showOutlinedButton(
                            function: () async {
                              if (formKey.currentState!.validate()) {
                                // Form is validated
                                ref.read(isLoadingProvider.notifier).state =
                                    true; // set loading to true
                                try {
                                  // Attempt to create user account
                                  await ref
                                      .read(firebaseAuthProvider)
                                      .createUserWithEmailAndPassword(
                                        email: emailController.text,
                                        userName: usernameController.text,
                                        password: passwordController.text,
                                        context: context,
                                      );
                                } catch (e) {
                                  // Handle error
                                  print('Error occurred: $e');
                                  // Optionally, show a snackbar or dialog to the user
                                }
                                ref.read(isLoadingProvider.notifier).state =
                                    false; // set loading to false
                              }
                            },
                            text: "Create Account",
                          ),
                    showsmallspace(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        mediumText(
                            text: "Already have an Account ? ",
                            fontWeight: FontWeight.normal),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const LoginScreen()));
                            },
                            child: const Text(
                              "Login",
                              style: TextStyle(color: Colors.green),
                            ))
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
