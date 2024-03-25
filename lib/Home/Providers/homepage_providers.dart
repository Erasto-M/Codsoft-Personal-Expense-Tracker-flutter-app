// alert dialog provider
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_expense_tracker_codsoft/Home/add_expense.dart';

final alertDialogProvider =
    Provider<AddExpenseDialog>((ref) => const AddExpenseDialog());
