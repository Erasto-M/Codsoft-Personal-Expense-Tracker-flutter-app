import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_expense_tracker_codsoft/Home/Providers/homepage_providers.dart';
import 'package:personal_expense_tracker_codsoft/Widgets/reusable_widgets.dart';

class AddExpenseDialog extends ConsumerWidget {
  const AddExpenseDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      title: mediumText(text: "Add Expense", fontWeight: FontWeight.bold),
      content: Column(
        children: [
          showTextFormField(
              controller: null,
              labelText: "Expense title",
              validator: null,
              prefixIcon: Icons.title,
              suffixIcon: null,
              textInputType: TextInputType.text,
              obscureText: false)
        ],
      ),
    );
  }
}
