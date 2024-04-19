import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:personal_expense_tracker_codsoft/Authentication/Screens/login_screen.dart';
import 'package:personal_expense_tracker_codsoft/Home/homepage.dart';
import 'package:personal_expense_tracker_codsoft/Widgets/colors.dart';

class AuthUser {
  //Auth state changes to check whether user is logged in or not
  Stream<User?> get authStateChanges =>
      FirebaseAuth.instance.authStateChanges();
  //create user with email and password
  Future<User?> createUserWithEmailAndPassword({
    required String email,
    required String userName,
    required String password,
    required BuildContext context,
  }) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((credentials) {
        FirebaseFirestore.instance
            .collection("Users")
            .doc(credentials.user!.uid)
            .set({
          "UserName": userName,
          "Email": email,
          "Uid": credentials.user!.uid,
        }).then((value) {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const HomePage()));
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Account Created Successfully")),
          );
        });
      });
      User? user = credential.user;
      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-passwprd') {
        print("Password is too weak");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Password is too weak")),
        );
      } else if (e.code == 'email-already-in-use') {
        print("Email Already in use");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text("Email already in use , use a different email")),
        );
      }
    } catch (e) {
      print(e.toString());
    }
  }

  //Signin user with email and password
  Future<void> signInUserWithEmailAndPassword({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((value) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
        );
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('User not Found');
      } else if (e.code == 'wrong-password') {
        print("Wrong password");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  // Sign out User
  Future<void> signOutUser(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut().then((value) {
        Fluttertoast.showToast(
          msg: "User Logged Out Successfully",
          toastLength: Toast.LENGTH_SHORT,
          textColor: Colors.white,
          gravity: ToastGravity.CENTER,
          backgroundColor: kcBackgroundColor,
          fontSize: 18,
        );
      }).then((value) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => LoginScreen()));
      });
    } catch (e) {
      print(e.toString());
    }
  }
}
