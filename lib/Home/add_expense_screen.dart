import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_expense_tracker_codsoft/Home/Backend/firebase_service.dart';
import 'package:personal_expense_tracker_codsoft/Home/Providers/homepage_providers.dart';
import 'package:personal_expense_tracker_codsoft/Home/homepage.dart';
import 'package:personal_expense_tracker_codsoft/Models/add_expense_Model.dart';
import 'package:personal_expense_tracker_codsoft/Widgets/colors.dart';
import 'package:personal_expense_tracker_codsoft/Widgets/reusable_widgets.dart';

StateProvider selectedCategoryProvider =
    StateProvider((ref) => 'Shopping & Foods');

class FormScreen extends ConsumerWidget {
  FormScreen({super.key});
  GlobalKey<FormState> formScreenKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final expenseTitleController = ref.watch(expenseTitleProvider);
    final expenseAmountController = ref.watch(expenseAmountProvider);
    final categories = ref.watch(expenseCategoryProvider);
    final isLoading = ref.watch(isExpenseLoadingProvider);
    final onButtonClick = ref.watch(addExpenseButtonTapped);
    final selectedCategory = ref.watch(selectedCategoryProvider);
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.arrow_back_outlined,
                    ),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  Text(
                    "Add Expense",
                    style: TextStyle(
                        color: kcBackgroundColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Form(
                  key: formScreenKey,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Title Cannot be empty";
                          }
                        },
                        keyboardType: TextInputType.text,
                        controller: expenseTitleController,
                        decoration: InputDecoration(
                            labelText: "Expense Title",
                            prefixIcon: const Icon(Icons.title),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            )),
                      ),
                      showsmallspace(),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please Enter the Amount of the Expense";
                          }
                        },
                        keyboardType: TextInputType.number,
                        controller: expenseAmountController,
                        decoration: InputDecoration(
                            labelText: "Amount",
                            prefixIcon: const Icon(Icons.money_rounded),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            )),
                      ),
                      showsmallspace(),
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black54,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey[200]),
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
                      showLargespace(),
                      isLoading
                          ? CircularProgressIndicator(
                              color: kcBackgroundColor,
                            )
                          : GestureDetector(
                              onTap: () {
                                ref
                                    .read(addExpenseButtonTapped.notifier)
                                    .state = true;
                                if (formScreenKey.currentState!.validate()) {
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
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    color: kcBackgroundColor,
                                    borderRadius: BorderRadius.circular(10)),
                                child: const Center(
                                  child: Text(
                                    "Submit Expense",
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
                  ))
            ],
          ),
        ),
      ),
    ));
  }
}
