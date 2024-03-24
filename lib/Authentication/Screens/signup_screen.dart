import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_expense_tracker_codsoft/Authentication/Providers/auth_providers.dart';
import 'package:personal_expense_tracker_codsoft/Widgets/reusable_widgets.dart';

class SignUpScreen extends ConsumerWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    //controllers
    final emailController = ref.watch(emailControllerProvider);
    final usernameController = ref.watch(userNameControllerProvider);
    final passwordController = ref.watch(passWordControllerProvider);
    final confirmPasswordController =
        ref.watch(confirmPasswordControllerProvider);
    //formKey
    //isLoading
    final isLoading = ref.watch(isLoadingProvider);
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
              Form(
                  key: formKey,
                  child: Column(
                    children: [
                      showTextFormField(
                          controller: usernameController,
                          labelText: "UserName",
                          validator: (value) {
                            if (value.isEmpty) {
                              return "UserName field cannot be empty";
                            }
                            return null;
                          },
                          prefixIcon: Icons.person_2_outlined,
                          suffixIcon: null,
                          textInputType: TextInputType.name,
                          obscureText: false),
                      showmediumspace(),
                      showTextFormField(
                          controller: emailController,
                          labelText: "Email",
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Email field cannot be empty';
                            } else if (!value.contains('@gmail.com')) {
                              return
                                  "Please enter a valid email address";
                            }
                            return null;
                          },
                          prefixIcon: Icons.email,
                          suffixIcon: null,
                          textInputType: TextInputType.emailAddress,
                          obscureText: false),
                      showmediumspace(),
                      showTextFormField(
                          controller: passwordController,
                          labelText: "Password",
                          validator: (value) {
                            if (value.isEmpty) {
                              return
                                  "password field cannot be empty";
                            } else if (value.length < 6) {
                              return "Too weak Password";
                            }
                            return null;
                          },
                          prefixIcon: Icons.lock,
                          suffixIcon: Icons.visibility_off,
                          textInputType: TextInputType.name,
                          obscureText: true),
                      showmediumspace(),
                      showTextFormField(
                        controller: confirmPasswordController,
                        labelText: "Confirm Password",
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Please confirm your password";
                          } else if (value != passwordController.text) {
                            return "Passwords do not Match";
                          }
                          return null;
                        },
                        prefixIcon: Icons.lock,
                        suffixIcon: Icons.visibility_off,
                        textInputType: TextInputType.name,
                        obscureText: true,
                      ),
                      showLargespace(),
                      isLoading
                          ? const CircularProgressIndicator()
                          : showOutlinedButton(
                              function: () async {
                                if (formKey.currentState!.validate()) {
                                  //set loading to true
                                  ref.read(isLoadingProvider.notifier).state =
                                      true;
                                  await ref
                                      .read(firebaseAuthProvider)
                                      .createUserWithEmailAndPassword(
                                          email: emailController.text,
                                          userName: usernameController.text,
                                          password: passwordController.text,
                                          context: context);
                                  ref.read(isLoadingProvider.notifier).state = false;
                                }
                                //validate form
                              },
                              text: "Create Account"),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
