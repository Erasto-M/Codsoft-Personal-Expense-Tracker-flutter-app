// alert dialog provider
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_expense_tracker_codsoft/Home/Backend/firebase_service.dart';
import 'package:personal_expense_tracker_codsoft/Home/add_expense.dart';
import 'package:personal_expense_tracker_codsoft/Models/add_expense_Model.dart';

final showAlertDialogProvider = StateProvider<bool>((ref) => false);

// add expense Providers
final expenseTitleProvider =
    StateProvider<TextEditingController>((ref) => TextEditingController());
final expenseAmountProvider =
    StateProvider<TextEditingController>((ref) => TextEditingController());
final expenseCategoryProvider = StateProvider((ref) => [
      'Shopping & Foods',
      'Utilities',
      'Transport',
      'Health and Fitness',
      'Personal Care',
      'Debts And Loans',
      'Entertainment',
    ]);
// is loading providers
final isExpenseLoadingProvider = StateProvider<bool>((ref) => false);

// button clicked provider
final addExpenseButtonTapped = StateProvider<bool>((ref) => false);

// provider for sending Firebase services
// get data from firebase provider
final getExpenseFromFirebaseProvider = StreamProvider((ref) {
  final firebaseServices = ref.watch(firebaseServicesProvider);
  return firebaseServices.fetchDailyExpenses() as Stream;
});
// selected category provider
final selectedCategoryProvider = StateProvider((ref) => null);
