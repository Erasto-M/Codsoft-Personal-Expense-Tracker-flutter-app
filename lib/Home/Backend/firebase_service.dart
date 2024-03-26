import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseServices{
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseDatabase database = FirebaseDatabase.instance;
  // Creating an expense
  static Future<void> createExpense()async{
    try{}on FirebaseAuthException catch(e){} catch(e){}
  }
  // Reading and Expense
 static Future<void> fetchDailyExpenses()async{
   try{}on FirebaseAuthException catch(e){} catch(e){}
 }
 // updating and expense
static Future<void> UpdateExpense()async{
  try{}catch(e){}
}
//Delete expense
static Future<void> deleteExpense()async{

}
}