// alert dialog provider
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_expense_tracker_codsoft/Home/Backend/firebase_service.dart';
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
final expnenseImagesProvider = StateProvider((ref) => [
      'assets/images/shopping.png',
      'assets/images/utilities.png',
      'assets/images/transport.png',
      'assets/images/health.png',
      'assets/images/personalcare.png',
      'assets/images/debts.png',
      'assets/images/entertainment2.jpg',
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

// total expense provider
// get total amount for all expenses in firebasec
final totalExpensesProvider = Provider((ref) {
  final expenses = ref.watch(getExpenseFromFirebaseProvider);
  double totalExpenses = expenses.when(data: (data) {
    return data
        .map<double>((expense) => double.tryParse(expense.amount) ?? 0.0)
        .fold(0.0, (prev, amount) => prev + amount);
  }, error: (err, _) {
    return 0.0;
  }, loading: () {
    return 0.0;
  });
  return totalExpenses;
});
// Total income Provider
final totalIncomeProvider = StateProvider<double>((ref) {
  return 50000.00;
});
// Monthy budget provider
final mothlyBudgetProvider = StateProvider<double>((ref) {
  return 30000.00;
});
// monthly budget calculator
final totalSavingsCalculatorProvider = Provider<double>((ref) {
  // Calculating the remaining amount from what  the user had budgeted
  final totalExpenses = ref.watch(totalExpensesProvider);
  final totalMonthlyBudget = ref.watch(mothlyBudgetProvider);
  final remainingMonthlyBudget = totalMonthlyBudget - totalExpenses;
  // calculating the remaining amount from the income
  final totalMonthlyincome = ref.watch(totalIncomeProvider);
  final savedFromIncome = totalMonthlyincome - totalMonthlyBudget;
  // total savings
  final totalSavings = remainingMonthlyBudget + savedFromIncome;
  return totalSavings;
});

// total expenses for each category
final totalExpensesForCategoryProvider =
    Provider.family<double, String>((ref, category) {
  final expenses = ref.watch(getExpenseFromFirebaseProvider);
  double totalExpenses = 0;
  // calculate the total expenses for a given category
  expenses.when(data: (data) {
    totalExpenses = data
        .where((expense) => expense.category == category)
        .map<double>((expense) => double.tryParse(expense.amount) ?? 0.0)
        .fold(0.0, (prev, amount) => prev + amount);
  }, error: (err, _) {
    totalExpenses = 0.0;
  }, loading: () {
    totalExpenses = 0.0;
  });
  return totalExpenses;
});
