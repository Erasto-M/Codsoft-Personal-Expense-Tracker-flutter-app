// alert dialog provider
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_expense_tracker_codsoft/Home/add_expense.dart';
 final showAlertDialogProvider = StateProvider<bool>((ref) => false);

 // add expense Providers
 final expenseTitleProvider = StateProvider<TextEditingController>((ref) => TextEditingController());
 final expenseAmountProvider = StateProvider<TextEditingController>((ref) => TextEditingController());
 final expenseCategoryProvider = StateProvider<TextEditingController>((ref) => TextEditingController());
 // is loading providers
 final isExpenseLoadingProvider = StateProvider<bool>((ref) => false);

 // button clicked provider
 final addExpenseButtonTapped = StateProvider<bool>((ref) => false);