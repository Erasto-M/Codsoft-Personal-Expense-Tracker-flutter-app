import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:personal_expense_tracker_codsoft/Models/add_expense_Model.dart';

final firebaseServicesProvider = Provider<FirebaseServices>((ref) {
  return FirebaseServices();
});

class FirebaseServices {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseDatabase database = FirebaseDatabase.instance;
  User? currentUser = FirebaseAuth.instance.currentUser;
  // Creating an expense
  Future<void> createExpense(AddExpenseModel expenseModel) async {
    try {
      if (currentUser != null) {
        final userId = currentUser!.uid;
        DocumentReference documentReference =
            FirebaseFirestore.instance.collection("Expenses").doc();
        final String docId = documentReference.id;
        final newExpenseWithId =
            expenseModel.copyWith(id: docId, userId: userId);
        await documentReference.set(newExpenseWithId.toMap());
        Fluttertoast.showToast(
          msg: "Expense added successfully",
          toastLength: Toast.LENGTH_SHORT,
          textColor: Colors.green,
          gravity: ToastGravity.TOP,
          backgroundColor: Colors.grey[500],
          fontSize: 18,
        );
      }
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: '$e');
    } catch (e) {
      Fluttertoast.showToast(msg: 'An error occured');
    }
  }

  // Reading and Expense
  Stream<List<AddExpenseModel>> fetchDailyExpenses() {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        String currentUserId = currentUser.uid;
        return FirebaseFirestore.instance
            .collection("Expenses")
            .snapshots()
            .map((snapshot) => snapshot.docs
                .map((e) =>
                    AddExpenseModel.fromMap(e.data() as Map<String, dynamic>))
                .toList());
      }
    } on FirebaseAuthException catch (e) {
    } catch (e) {}
    return Stream.value([]);
  }

  // updating and expense
  static Future<void> UpdateExpense() async {
    try {} catch (e) {}
  }

//Delete expense
  static Future<void> deleteExpense() async {}
}
