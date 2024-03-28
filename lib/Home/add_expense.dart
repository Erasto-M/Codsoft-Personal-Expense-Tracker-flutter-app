import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_expense_tracker_codsoft/Home/Providers/homepage_providers.dart';
import 'package:personal_expense_tracker_codsoft/Models/add_expense_Model.dart';
import 'package:personal_expense_tracker_codsoft/Widgets/colors.dart';
import 'package:personal_expense_tracker_codsoft/Widgets/reusable_widgets.dart';
// controllers

showAlertDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return Consumer(builder: (context, ref, child) {
          final expenseTitleController = ref.watch(expenseTitleProvider);
          final expenseAmountController = ref.watch(expenseAmountProvider);
          final expenseCategoryController = ref.watch(expenseCategoryProvider);
          final _isLoading = ref.watch(isExpenseLoadingProvider);
          final _OnButtonClick = ref.watch(addExpenseButtonTapped);
          GlobalKey<FormState> _expenseFormKey = GlobalKey<FormState>();
          return AlertDialog(
            elevation: 5,
            shape: const RoundedRectangleBorder(),
            title: Center(
                child: mediumText(
                    text: "Add Expense", fontWeight: FontWeight.bold)),
            content: Container(
                height: _OnButtonClick? 400: 300,
                child: Form(
                  key: _expenseFormKey,
                  child: Column(
                    children: [
                      showTextFormField(
                          controller: expenseTitleController,
                          labelText: "Expense title",
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Title Cannot be empty";
                            }
                          },
                          prefixIcon: Icons.title,
                          suffixIcon: null,
                          textInputType: TextInputType.text,
                          obscureText: false),
                      showmediumspace(),
                      showTextFormField(
                          controller: expenseAmountController,
                          labelText: "Amount",
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please Enter the Amount of the Expense";
                            }
                          },
                          prefixIcon: Icons.money_sharp,
                          suffixIcon: null,
                          textInputType: TextInputType.text,
                          obscureText: false),
                      showmediumspace(),
                      showTextFormField(
                          controller: expenseCategoryController,
                          labelText: "Category",
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please select category";
                            }
                          },
                          prefixIcon: Icons.category,
                          suffixIcon: null,
                          textInputType: TextInputType.text,
                          obscureText: false),
                      showmediumspace(),
                      _isLoading
                          ? CircularProgressIndicator(
                              color: kcBackgroundColor,
                            )
                          : GestureDetector(
                              onTap: () {
                                ref.read(addExpenseButtonTapped.notifier).state = true;
                                if(_expenseFormKey.currentState!.validate()){
                                  ref.read( isExpenseLoadingProvider.notifier).state = true;
                                  AddExpenseModel expenseModel =
                                  AddExpenseModel(amount: expenseAmountController.text,
                                      category: expenseCategoryController.text, title: expenseTitleController.text);
                                  ref.read(firebaseServicesProvider).createExpense(expenseModel);
                                  Navigator.pop(context);
                                }
                              },
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 10,
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 100, vertical: 10),
                                decoration: BoxDecoration(
                                    color: kcBackgroundColor,
                                    borderRadius: BorderRadius.circular(20)),
                                child: const Text(
                                  "Add ",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            )
                    ],
                  ),
                )),
          );
        });
      });
}
