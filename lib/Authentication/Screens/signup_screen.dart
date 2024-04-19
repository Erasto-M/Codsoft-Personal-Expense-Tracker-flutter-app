import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_expense_tracker_codsoft/Authentication/Providers/auth_providers.dart';
import 'package:personal_expense_tracker_codsoft/Authentication/Screens/login_screen.dart';
import 'package:personal_expense_tracker_codsoft/Widgets/colors.dart';
import 'package:personal_expense_tracker_codsoft/Widgets/reusable_widgets.dart';

class SignUpScreen extends ConsumerWidget {
  SignUpScreen({Key? key}) : super(key: key);
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
          padding:
              const EdgeInsets.only(top: 1, right: 15, left: 15, bottom: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/download.png",
                  height: 250,
                  width: 300,
                ),
                Text(
                  "Sign Up",
                  style: TextStyle(
                      color: kcBackgroundColor,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                showmediumspace(),
                const Text(
                  "Create account to get things done",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.normal),
                ),
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
                          : GestureDetector(
                              onTap: () async {
                                if (formKey.currentState!.validate()) {
                                  // Form is validated
                                  ref.read(isLoadingProvider.notifier).state =
                                      true; // set loading to true
                                  try {
                                    debugPrint("ready to send data ");
                                    await ref
                                        .read(firebaseAuthProvider)
                                        .createUserWithEmailAndPassword(
                                          email: emailController.text,
                                          userName: usernameController.text,
                                          password: passwordController.text,
                                          context: context,
                                        );
                                  } catch (e) {
                                    print('Error occurred: $e');
                                  }
                                  ref.read(isLoadingProvider.notifier).state =
                                      false;
                                }
                              },
                              child: Container(
                                height: 50,
                                padding:
                                    const EdgeInsets.only(left: 50, right: 50),
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    color: kcBackgroundColor,
                                    borderRadius: BorderRadius.circular(10)),
                                child: const Row(
                                  children: [
                                    Center(
                                      child: Text(
                                        "Create Account",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 30,
                                        ),
                                      ),
                                    ),
                                    Spacer(),
                                    Icon(
                                      Icons.arrow_forward_ios_outlined,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
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
                                    builder: (context) => LoginScreen()));
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
      ),
    );
  }
}
