// reusable Textformfields
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:personal_expense_tracker_codsoft/Home/Providers/homepage_providers.dart';
import 'package:personal_expense_tracker_codsoft/Widgets/colors.dart';

TextFormField showTextFormField({
  required TextEditingController? controller,
  required String labelText,
  required Function(String?)? validator,
  required IconData prefixIcon,
  required IconData? suffixIcon,
  required TextInputType textInputType,
  required bool obscureText,
}) {
  return TextFormField(
    keyboardType: textInputType,
    controller: controller,
    autovalidateMode: AutovalidateMode.disabled,
    textCapitalization: TextCapitalization.sentences,
    textAlign: TextAlign.start,
    autocorrect: true,
    validator: validator as String? Function(String?)?,
    obscureText: obscureText,
    decoration: InputDecoration(
      prefixIcon: Icon(prefixIcon),
      suffixIcon: GestureDetector(child: Icon(suffixIcon)),
      labelText: labelText,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );
}

//reusable texts
// big Text
Text showBigText({
  required String text,
}) {
  return Text(
    text,
    style: TextStyle(
      color: bigTextcolor,
      fontSize: 17,
      fontWeight: FontWeight.bold,
    ),
  );
}

// medium text
Text mediumText({
  required String text,
  required FontWeight fontWeight,
}) {
  return Text(
    text,
    style: TextStyle(
      color: mediumTextcolor,
      fontSize: 18,
      fontWeight: fontWeight,
    ),
  );
}

//small Text
Text smallText({
  required String text,
  required FontWeight fontWeight,
}) {
  return Text(
    text,
    style: TextStyle(
      color: smallTextcolor,
      fontSize: 16,
      fontWeight: fontWeight,
    ),
  );
}

// reusable  buttons
// Outlined buttons
Widget showOutlinedButton({
  required Function() function,
  required String text,
}) {
  return Container(
    margin: const EdgeInsets.all(10),
    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
    child: OutlinedButton(
      style: OutlinedButton.styleFrom(
        backgroundColor: outlinedButtonColors,
      ),
      onPressed: function,
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}

// reusable  spacing
// Large space
Widget showLargespace() {
  return const SizedBox(
    height: 20,
  );
}

// medium space
Widget showmediumspace() {
  return const SizedBox(
    height: 15,
  );
}

// small space
Widget showsmallspace() {
  return const SizedBox(
    height: 20,
  );
}

showExpenseConatiner(BuildContext context) {
  return Consumer(builder: (context, ref, child) {
    final totalIncome = ref.watch(totalIncomeProvider).toStringAsFixed(2);
    final totalMonthlyBudget =
        ref.watch(mothlyBudgetProvider).toStringAsFixed(2);
    final totalExpenses = ref.watch(totalExpensesProvider).toStringAsFixed(2);
    final totalSavings =
        ref.watch(totalSavingsCalculatorProvider).toStringAsFixed(2);
    double expenseAmount = double.tryParse(totalExpenses) ?? 0.0;
    double savingsAmount = double.tryParse(totalSavings) ?? 0.0;
    double incomeAmount = double.tryParse(totalIncome) ?? 0.0;
    double monthlyBudgetAmont = double.tryParse(totalMonthlyBudget) ?? 0.0;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      height: 150,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: kcBackgroundColor),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Column(
                children: [
                  const Text(
                    "Total Income",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Text(
                    NumberFormat.currency(symbol: '\$', decimalDigits: 2)
                        .format(incomeAmount),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Column(
                children: [
                  const Text(
                    "Total Balance",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    NumberFormat.currency(symbol: '\$', decimalDigits: 2)
                        .format(savingsAmount),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Spacer(),
          Column(
            children: [
              Column(
                children: [
                  const Text(
                    "Monthly Budget",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Text(
                    NumberFormat.currency(symbol: '\$', decimalDigits: 2)
                        .format(monthlyBudgetAmont),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Column(
                children: [
                  const Text(
                    "Total Expense",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    NumberFormat.currency(symbol: '\$', decimalDigits: 2)
                        .format(expenseAmount),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ],
          ),
          // const Spacer(),
          // Center(
          //     child: Container(
          //   decoration: BoxDecoration(
          //     color: Colors.grey[200],
          //     borderRadius: BorderRadius.circular(15),
          //   ),
          //   padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          //   child: Row(
          //     children: [
          //       mediumText(text: "FEB", fontWeight: FontWeight.w100),
          //       const SizedBox(
          //         width: 5,
          //       ),
          //       const Icon(
          //         Icons.arrow_drop_down,
          //       )
          //     ],
          //   ),
          // )),
        ],
      ),
    );
  });
}
