import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:personal_expense_tracker_codsoft/Authentication/Providers/auth_providers.dart';
import 'package:personal_expense_tracker_codsoft/Authentication/Screens/loading_screen.dart';
import 'package:personal_expense_tracker_codsoft/Home/Backend/firebase_service.dart';
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
                          text: "Erastus Munyao", fontWeight: FontWeight.bold),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      showBigText(text: "Logout"),
                      IconButton(
                          onPressed: () {
                            ref.read(firebaseAuthProvider).signOutUser(context);
                          },
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
              showsmallspace(),
              showBigText(text: "Expense Summaries"),
              showsmallspace(),
              showExpenseConatiner(context),
              showmediumspace(),
              // categories listview
              showBigText(text: "Categories"),
              // Container for the Categories
              Container(
                height: MediaQuery.of(context).size.height / 10,
                child: getExpenseFromFirebase.when(data: (data) {
                  final categories = ref.watch(expenseCategoryProvider);
                  return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      itemBuilder: (context, Index) {
                        final expenseCategoryTitle = categories[Index];
                        final totalExpenseForCategories = ref.watch(
                            totalExpensesForCategoryProvider(
                                expenseCategoryTitle));
                        double totalExpense = double.tryParse(
                                totalExpenseForCategories.toStringAsFixed(2)) ??
                            0.0;
                        return GestureDetector(
                          onTap: () {
                            ref.read(selectedCategoryProvider.notifier).state =
                                expenseCategoryTitle;
                          },
                          child: Container(
                              height: MediaQuery.of(context).size.height / 6,
                              margin: const EdgeInsets.all(10),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              width: MediaQuery.of(context).size.width / 2.6,
                              decoration: BoxDecoration(
                                color: selectedCategory == expenseCategoryTitle
                                    ? const Color.fromARGB(255, 81, 112, 82)
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 5,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: ListView(
                                children: [
                                  selectedCategory == expenseCategoryTitle
                                      ? Text(
                                          expenseCategoryTitle,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        )
                                      : Text(expenseCategoryTitle),
                                  // the total  expense for each category
                                  Text(
                                    NumberFormat.currency(
                                            symbol: '\$', decimalDigits: 2)
                                        .format(totalExpense),
                                    style:
                                        selectedCategory == expenseCategoryTitle
                                            ? const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold)
                                            : const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                  ),
                                ],
                              )),
                        );
                      });
                }, error: (err, _) {
                  return Text(
                    err.toString(),
                  );
                }, loading: () {
                  return const LoadingScreen();
                }),
              ),
              showmediumspace(),
              showBigText(text: "Today"),
              showmediumspace(),
              // Listview for showing expenses for the selected category
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
                                  ),
                                  const Spacer(),
                                  Text(NumberFormat.currency(
                                          symbol: '\$', decimalDigits: 2)
                                      .format(amount))
                                ],
                              ),
                              subtitle: Text(
                                dateFormat.toString(),
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                              trailing: IconButton(
                                onPressed: () {
                                  ref
                                      .read(firebaseServicesProvider)
                                      .deleteExpense(expenseId: expense.id!);
                                },
                                icon: Icon(
                                  Icons.delete,
                                  color: kcBackgroundColor,
                                ),
                              ),
                            ),
                          );
                        });
                  } else {
                    return const Center(
                        child: Text(
                      "No Expenses , click the Add Icon below to add",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ));
                  }
                }, error: (err, _) {
                  return Center(child: Text(err.toString()));
                }, loading: () {
                  return const LoadingScreen();
                }),
              ),
              // Daily Expanses List
            ],
          ),
        ),
        //floating action button for calling the add expense dialog

        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Consumer(
          builder: (context, ref, child) {
            return FloatingActionButton(
              shape: const CircleBorder(),
              backgroundColor: kcBackgroundColor,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => FormScreen(),
                  ),
                );
              },
              tooltip: "Add Expense",
              child: const Icon(
                Icons.add,
                size: 30,
                color: Colors.white,
              ),
            );
          },
        ),
      ),
    );
  }
}
