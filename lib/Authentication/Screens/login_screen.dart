import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_expense_tracker_codsoft/Authentication/Providers/auth_providers.dart';
import 'package:personal_expense_tracker_codsoft/Authentication/Screens/signup_screen.dart';
import 'package:personal_expense_tracker_codsoft/Widgets/colors.dart';
import 'package:personal_expense_tracker_codsoft/Widgets/reusable_widgets.dart';

// login class using the riverpod state management
class LoginScreen extends ConsumerWidget {
  LoginScreen({super.key});
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Controllers
    final signInemailController = ref.watch(signInEmailControllerProvider);
    final signInpasswordController =
        ref.watch(signInPasswordControllerProvider);
    // isLoading
    final isLoading = ref.watch(isLoadingProvider);

    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(15),
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
                  "Login",
                  style: TextStyle(
                      color: kcBackgroundColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                showmediumspace(),
                mediumText(text: "Welcome Back", fontWeight: FontWeight.w200),
                showLargespace(),
                showLargespace(),
                showLargespace(),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      showmediumspace(),
                      showTextFormField(
                        controller: signInemailController,
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
                        controller: signInpasswordController,
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
                                    // Attempt to create user account
                                    await ref
                                        .read(firebaseAuthProvider)
                                        .signInUserWithEmailAndPassword(
                                          email: signInemailController.text,
                                          password:
                                              signInpasswordController.text,
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
                              child: Container(
                                height: 50,
                                padding: const EdgeInsets.only(
                                    left: 150, right: 100),
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    color: kcBackgroundColor,
                                    borderRadius: BorderRadius.circular(10)),
                                child: const Row(
                                  children: [
                                    Center(
                                      child: Text(
                                        "Login",
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
                              text: "Don't have an Account ? ",
                              fontWeight: FontWeight.normal),
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => SignUpScreen()));
                              },
                              child: const Text(
                                "Register",
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
