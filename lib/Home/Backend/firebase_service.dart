import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:personal_expense_tracker_codsoft/Models/add_expense_Model.dart';

class FirebaseServices{
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseDatabase database = FirebaseDatabase.instance;
  User? currentUser = FirebaseAuth.instance.currentUser;
  // Creating an expense
   Future<void> createExpense(AddExpenseModel expenseModel)async{
    try{
      if(currentUser!=null){
        final userId = currentUser!.uid;
        DocumentReference documentReference = await FirebaseFirestore.instance.collection("Expenses").doc();
         final String docId = documentReference.id;
         final newExpenseWithId = expenseModel.copyWith(id: docId, userId: userId);
         documentReference.set(newExpenseWithId.toMap());

      }
    }on FirebaseAuthException catch(e){} catch(e){}
  }
  // Reading and Expense
 Future<List<AddExpenseModel>?> fetchDailyExpenses()async{
   try{
     final currentUser = firebaseAuth.currentUser;
     if(currentUser!=null){
       final String userId = currentUser.uid;
       QuerySnapshot allExpenses =await  firebaseFirestore.collection("Expenses").where("Uid" , isEqualTo: userId).get();
       return allExpenses.docs.map((expense) =>AddExpenseModel.fromMap(expense.data() as Map<String, dynamic>)).toList();
     }
   }on FirebaseAuthException catch(e){} catch(e){}
   return null;
 }
 // updating and expense
static Future<void> UpdateExpense()async{
  try{}catch(e){}
}
//Delete expense
static Future<void> deleteExpense()async{

}
}