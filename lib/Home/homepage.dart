import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:personal_expense_tracker_codsoft/Authentication/Screens/loading_screen.dart';
import 'package:personal_expense_tracker_codsoft/Home/Providers/homepage_providers.dart';
import 'package:personal_expense_tracker_codsoft/Home/add_expense_screen.dart';
import 'package:personal_expense_tracker_codsoft/Models/add_expense_Model.dart';
import 'package:personal_expense_tracker_codsoft/Widgets/colors.dart';
import 'package:personal_expense_tracker_codsoft/Widgets/reusable_widgets.dart';

// selected Category
final selectedCategoryProvider = StateProvider((ref) {
  return 'Shopping & Foods';
});

class HomePage extends ConsumerWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final getExpenseFromFirebase = ref.watch(getExpenseFromFirebaseProvider);
    final selectedCategory = ref.watch(selectedCategoryProvider);
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.grey[200],
          body: Container(
            padding:
                const EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 10),
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
                showExpenseConatiner(context),
                showmediumspace(),
                // categories listview
                showBigText(text: "Categories", fontWeight: FontWeight.bold),

                Container(
                  height: MediaQuery.of(context).size.height / 10,
                  child: getExpenseFromFirebase.when(data: (data) {
                    final Set<String> uniqueCategories = Set<String>();
                    return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: data.length,
                        itemBuilder: (context, Index) {
                          AddExpenseModel expenseCategory = data[Index];
                          if (!uniqueCategories
                              .contains(expenseCategory.category)) {
                            uniqueCategories.add(expenseCategory.category);
                            return GestureDetector(
                              onTap: () {
                                ref
                                    .read(selectedCategoryProvider.notifier)
                                    .state = expenseCategory.category ?? '';
                              },
                              child: Container(
                                height: MediaQuery.of(context).size.height / 6,
                                margin: const EdgeInsets.all(10),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                width: MediaQuery.of(context).size.width / 2.6,
                                decoration: BoxDecoration(
                                  color: selectedCategory ==
                                          expenseCategory.category
                                      ? Colors.grey
                                      : Colors.white,
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
                              ),
                            );
                          }
                        });
                  }, error: (err, _) {
                    return Text(err.toString());
                  }, loading: () {
                    return const LoadingScreen();
                  }),
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
                          AddExpenseModel expense = data[index];
                          if (selectedCategory != '' &&
                              selectedCategory != expense.category) {
                            return const SizedBox.shrink();
                          }
                          String dateFormat =
                              DateFormat('dd-MM-yyyy').format(expense.date!);
                          double amount =
                              double.tryParse(expense.amount) ?? 0.0;
                          return Container(
                            margin: const EdgeInsets.only(bottom: 5),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
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
                              subtitle: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    expense.category,
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 13,
                                  ),
                                  Text(
                                    dateFormat.toString(),
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  )
                                ],
                              ),
                              trailing: IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.blue,
                                ),
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
