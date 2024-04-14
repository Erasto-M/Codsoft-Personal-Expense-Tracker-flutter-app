import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_expense_tracker_codsoft/Home/Backend/firebase_service.dart';
import 'package:personal_expense_tracker_codsoft/Home/Providers/homepage_providers.dart';
import 'package:personal_expense_tracker_codsoft/Models/add_expense_Model.dart';
import 'package:personal_expense_tracker_codsoft/Widgets/colors.dart';
import 'package:personal_expense_tracker_codsoft/Widgets/reusable_widgets.dart';

StateProvider selectedCategoryProvider =
    StateProvider((ref) => 'Shopping & Foods');

showAlertDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return Consumer(builder: (context, ref, child) {
          final expenseTitleController = ref.watch(expenseTitleProvider);
          final expenseAmountController = ref.watch(expenseAmountProvider);
          final categories = ref.watch(expenseCategoryProvider);
          final isLoading = ref.watch(isExpenseLoadingProvider);
          final onButtonClick = ref.watch(addExpenseButtonTapped);
          final selectedCategory = ref.watch(selectedCategoryProvider);
          GlobalKey<FormState> expenseFormKey = GlobalKey<FormState>();
          return AlertDialog(
            elevation: 5,
            shape: const RoundedRectangleBorder(),
            title: Center(
                child: mediumText(
                    text: "Add Expense", fontWeight: FontWeight.bold)),
            content: Container(
                height: onButtonClick ? 380 : 290,
                child: Form(
                  key: expenseFormKey,
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
                      Container(
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Select Category",
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            DropdownButton(
                              value: selectedCategory,
                              icon: const Icon(Icons.arrow_drop_down),
                              items: categories.map((categoryValue) {
                                return DropdownMenuItem(
                                  value: categoryValue,
                                  child: Text(categoryValue),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                ref
                                    .read(selectedCategoryProvider.notifier)
                                    .state = newValue ?? '';
                              },
                            ),
                          ],
                        ),
                      ),
                      showmediumspace(),
                      isLoading
                          ? CircularProgressIndicator(
                              color: kcBackgroundColor,
                            )
                          : GestureDetector(
                              onTap: () {
                                ref
                                    .read(addExpenseButtonTapped.notifier)
                                    .state = true;
                                if (expenseFormKey.currentState!.validate()) {
                                  ref
                                      .read(isExpenseLoadingProvider.notifier)
                                      .state = true;
                                  AddExpenseModel expenseModel =
                                      AddExpenseModel(
                                          title: expenseTitleController.text,
                                          amount: expenseAmountController.text,
                                          category: selectedCategory);
                                  ref
                                      .read(firebaseServicesProvider)
                                      .createExpense(expenseModel);
                                  ref
                                      .read(expenseTitleProvider.notifier)
                                      .state
                                      .clear();
                                  ref
                                      .read(expenseAmountProvider.notifier)
                                      .state
                                      .clear();

                                  ref
                                      .read(isExpenseLoadingProvider.notifier)
                                      .state = false;
                                  Navigator.pop(context);
                                }
                              },
                              child: Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width / 2,
                                decoration: BoxDecoration(
                                    color: kcBackgroundColor,
                                    borderRadius: BorderRadius.circular(20)),
                                child: const Center(
                                  child: Text(
                                    "Add",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
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
