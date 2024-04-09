import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:personal_expense_tracker_codsoft/Authentication/Screens/loading_screen.dart';
import 'package:personal_expense_tracker_codsoft/Home/Providers/homepage_providers.dart';
import 'package:personal_expense_tracker_codsoft/Widgets/colors.dart';
import 'package:personal_expense_tracker_codsoft/Widgets/reusable_widgets.dart';

import 'add_expense.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final getExpenseFromFirebase = ref.watch(getExpenseFromFirebaseProvider);
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
                Flexible(
                  flex: 1,
                  child: Container(
                    child: getExpenseFromFirebase.when(data: (data) {
                      return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: data.length,
                          itemBuilder: (context, Index) {
                            final expenseCategory = data[Index];
                            return Container(
                              margin: const EdgeInsets.all(10),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              width: MediaQuery.of(context).size.width / 2.5,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 5,
                                    offset: Offset(0, 3),
                                  )
                                ],
                              ),
                              child: Text(expenseCategory.category),
                            );
                          });
                    }, error: (err, _) {
                      return Text(err.toString());
                    }, loading: () {
                      return const LoadingScreen();
                    }),
                  ),
                ),
                showmediumspace(),
                showBigText(text: "Today", fontWeight: FontWeight.bold),
                showmediumspace(),
                Expanded(
                    child: getExpenseFromFirebase.when(data: (data) {
                  if (data.isNotEmpty) {
                    return ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          final expense = data[index];
                          String dateFormat =
                              DateFormat('dd-MM-yyyy').format(expense.date);
                          double amount =
                              double.tryParse(expense.amount) ?? 0.0;
                          return Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 5,
                                    offset: Offset(0, 3),
                                  )
                                ]),
                            child: ListTile(
                              title: Row(
                                children: [
                                  Text(
                                    expense.title,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const Spacer(),
                                  Text(NumberFormat.currency(
                                          symbol: '\$', decimalDigits: 0)
                                      .format(amount))
                                ],
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    expense.category,
                                  ),
                                  Text(dateFormat.toString())
                                ],
                              ),
                            ),
                          );
                        });
                  } else {
                    return const Center(child: Text("No data Found"));
                  }
                }, error: (err, _) {
                  return Center(child: Text(err.toString()));
                }, loading: () {
                  return const LoadingScreen();
                }))
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
