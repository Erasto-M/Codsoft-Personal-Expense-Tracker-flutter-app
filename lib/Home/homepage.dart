import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_expense_tracker_codsoft/Authentication/Screens/loading_screen.dart';
import 'package:personal_expense_tracker_codsoft/Home/Backend/firebase_service.dart';
import 'package:personal_expense_tracker_codsoft/Home/Providers/homepage_providers.dart';
import 'package:personal_expense_tracker_codsoft/Models/add_expense_Model.dart';
import 'package:personal_expense_tracker_codsoft/Widgets/colors.dart';
import 'package:personal_expense_tracker_codsoft/Widgets/reusable_widgets.dart';

import 'add_expense.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.grey[200],
          body: Container(
            padding:
                const EdgeInsets.only(top: 30, left: 15, right: 15, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // salution and Logout row
                Row(
                  children: [
                    //user image
                    const CircleAvatar(),
                    const SizedBox(
                      width: 15,
                    ),
                    // hello user column
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        mediumText(
                            text: "Hello There ", fontWeight: FontWeight.bold),
                        smallText(
                            text: "Erastus Munyao",
                            fontWeight: FontWeight.bold),
                      ],
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        showBigText(
                            text: "Logout", fontWeight: FontWeight.bold),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.logout,
                              size: 25,
                              color: Colors.black,
                            ))
                      ],
                    )
                  ],
                ),
                // Momthly budget container
                showmediumspace(),
                Container(
                  padding: const EdgeInsets.all(10),
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: kcBackgroundColor),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       const Column(
                        children: [
                          Column(
                            children: [
                              Text(
                                "Total Income",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              Text(
                                "& 50,000",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          Column(
                            children: [
                              Text(
                                "Total Savings",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "& 20,000",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Spacer(),
                      const Column(
                        children: [
                          Column(
                            children: [
                              Text(
                                "Monthly Budget",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              Text(
                                "& 40,000",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          Column(
                            children: [
                              Text(
                                "Total Expense",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "& 30,000",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Spacer(),
                      Center(
                          child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 5),
                        child: Row(
                          children: [
                            mediumText(
                                text: "FEB", fontWeight: FontWeight.w100),
                            const SizedBox(
                              width: 5,
                            ),
                            const Icon(
                              Icons.arrow_drop_down,
                            )
                          ],
                        ),
                      ))
                    ],
                  ),
                ),
                showmediumspace(),
                // categories listview
                showBigText(text: "Categories", fontWeight: FontWeight.bold),
                showmediumspace(),
                const Expanded(child: FetchedExpenses()),
                // Daily Expanses List
              ],
            ),
          ),
          //floating action button for calling the add expense dialog
          floatingActionButton: Consumer(
            builder: (context, ref, child) {
              return FloatingActionButton.extended(
                  backgroundColor: kcBackgroundColor,
                  onPressed: () {
                    final showDialogCurrentState =
                        ref.read(showAlertDialogProvider.notifier).state = true;
                    if (showDialogCurrentState) {
                      showAlertDialog(context);
                    } else {
                      const SizedBox();
                    }
                  },
                  label: Column(
                    children: [
                      const Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                      mediumText(
                          text: "Add Expense", fontWeight: FontWeight.bold),
                    ],
                  ));
            },
          )),
    );
  }
}

class FetchedExpenses extends StatelessWidget {
  const FetchedExpenses({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final AsyncValue<List<AddExpenseModel>> dailyExpenses =
          ref.watch(getExpensesFromFirebaseProvider);
      return dailyExpenses.when(
          data: (expenses) {
            if (expenses == null || expenses.isEmpty) {
              return const Text("No expenses Found");
            } else {
              return ListView.builder(
                  itemCount: expenses.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final expense = expenses[index];
                    return ListTile(
                      title: Text(expense.title),
                      subtitle: Text(expense.date as String),
                      trailing:Text(expense.amount ),
                    );
                  });
            }
          },
          error: (err, stacktrace) {
            return Text('e'.toString());
          },
          loading: () => const LoadingScreen());
    });
  }
}
