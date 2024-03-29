import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:personal_expense_tracker_codsoft/Home/Providers/homepage_providers.dart';
import 'package:personal_expense_tracker_codsoft/Models/add_expense_Model.dart';
import 'package:personal_expense_tracker_codsoft/Widgets/colors.dart';
import 'package:personal_expense_tracker_codsoft/Widgets/reusable_widgets.dart';
// controllers
final List<String> categoriesList = [
  'Shopping & Foods\n',
      'Utilities\n',
      'Transport\n',
      'Health and Fitness\n',
      'Personal Care\n',
      'Debts And Loans\n',
      'Entertainment\n',
];
 String? selectedCategory;
showAlertDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return Consumer(builder: (context, ref, child) {
          final expenseTitleController = ref.watch(expenseTitleProvider);
          final expenseAmountController = ref.watch(expenseAmountProvider);
          final expenseCategoryController = ref.watch(expenseCategoryProvider);
          final isLoading = ref.watch(isExpenseLoadingProvider);
          final onButtonClick = ref.watch(addExpenseButtonTapped);
          GlobalKey<FormState> expenseFormKey = GlobalKey<FormState>();
          return AlertDialog(
            elevation: 5,
            shape: const RoundedRectangleBorder(),
            title: Center(
                child: mediumText(
                    text: "Add Expense", fontWeight: FontWeight.bold)),
            content: Container(
                height: onButtonClick? 380: 290,
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
                          onTap: null,
                          readonly: false,
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
                          onTap: null,
                          prefixIcon: Icons.money_sharp,
                          suffixIcon: null,
                          readonly: false,
                          textInputType: TextInputType.text,
                          obscureText: false),
                      showmediumspace(),
                      showTextFormField(
                          readonly: true,
                          controller: expenseCategoryController,
                          labelText: "Category",
                          onTap: (){
                            _showSelectedCategory(context);
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please select category";
                            }
                          },
                          prefixIcon: Icons.category,
                          suffixIcon: Icons.arrow_drop_down,
                          textInputType: TextInputType.text,
                          obscureText: false),
                      showmediumspace(),
                      isLoading
                          ? CircularProgressIndicator(
                              color: kcBackgroundColor,
                            )
                          : GestureDetector(
                              onTap: () {
                                ref.read(addExpenseButtonTapped.notifier).state = true;
                                if(expenseFormKey.currentState!.validate()){
                                  ref.read( isExpenseLoadingProvider.notifier).state = true;
                                  AddExpenseModel expenseModel =
                                  AddExpenseModel(amount: expenseAmountController.text,
                                      category: expenseCategoryController.text, title: expenseTitleController.text);
                                  ref.read(firebaseServicesProvider).createExpense(expenseModel);
                                  ref.read(expenseTitleProvider.notifier).state.clear();
                                  ref.read(expenseAmountProvider.notifier).state.clear();
                                  ref.read(expenseCategoryProvider.notifier).state.clear();
                                  ref.read(isExpenseLoadingProvider.notifier).state = false;
                                  Navigator.pop(context);
                                }
                              },
                              child: Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width/2,
                                decoration: BoxDecoration(
                                    color: kcBackgroundColor,
                                    borderRadius: BorderRadius.circular(20)),
                                child: const Center(
                                  child:  Text(
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
  Widget? _showSelectedCategory(BuildContext context){
  showDialog(context: context, builder: (context){
    return AlertDialog(
      title: mediumText(text: "select category", fontWeight: FontWeight.bold),
      content:Container(
        width: double.minPositive,
        child: ListView.builder(
          itemCount: categoriesList.length,
            shrinkWrap: true,
            itemBuilder: (ref, index){
            return Consumer(builder: (context, ref, child){
              final isSelected = selectedCategory == categoriesList[index];
              return ListTile(
                title: Text(categoriesList[index],
                  style: isSelected ?const  TextStyle(color: Colors.blue): const TextStyle(color: Colors.black),
                ),
                onTap: (){
                  selectedCategory = categoriesList[index];
                  ref.read(expenseCategoryProvider.notifier).state = TextEditingController(text: selectedCategory);
                  Navigator.pop(context);
                },
              );
            });
        }),
      ) ,
    );
  });
  return null;
  }
