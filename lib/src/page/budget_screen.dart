import 'package:flutter/material.dart';
import 'package:spendwise/core/constants/constant_widgets/apptextfield.dart';
import 'package:spendwise/services/models/budgets/firebase_budget_storage.dart';

class BudgetScreen extends StatefulWidget {
  const BudgetScreen({super.key});

  @override
  State<BudgetScreen> createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen> {
  late final FirebaseBudgetStorage budgetDatabase;
  late final TextEditingController titleController;
  late final TextEditingController amountController;

  @override
  void initState() {
    titleController = TextEditingController();
    amountController = TextEditingController();
    budgetDatabase = FirebaseBudgetStorage();
    super.initState();
  }

  void gotBudget() {
    if (titleController.text.isNotEmpty && amountController.text.isNotEmpty) {
      String newTitle = titleController.text;
      int newAmount = int.parse(amountController.text);

      budgetDatabase.addBudget(newTitle, newAmount);
    }

    titleController.clear();
    amountController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BudgetScreen'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 16.0),
          child: Column(
            children: [
              AppCustomTextField(
                controller: titleController,
                hintText: 'Ttitle',
                textInputType: TextInputType.text,
                autoFocus: true,
                obscureText: false,
                autoCorrect: true,
              ),
              const SizedBox(
                height: 10,
              ),
              AppCustomTextField(
                controller: amountController,
                hintText: 'Amount',
                textInputType: TextInputType.number,
                autoCorrect: false,
                autoFocus: false,
                obscureText: false,
              ),
              const SizedBox(
                height: 20,
              ),
              AppButton(
                onTap: () {
                  gotBudget();
                },
                text: 'Add Budget',
              ),
              const SizedBox(
                height: 20,
              ),
              StreamBuilder(
                stream: budgetDatabase.getBudgetStream(),
                builder: (context, snapshot) {
                  // show loading
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text('Waiting for data');
                  }
                  // get the budgets
                  final budget = snapshot.data!.docs;

                  // no data
                  if (snapshot.data == null || budget.isEmpty) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(25),
                        child: Text('No Data'),
                      ),
                    );
                  }

                  // return a list
                  if (snapshot.hasData) {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: budget.length,
                        itemBuilder: (context, index) {
                          // get the individual post
                          final budgets = budget[index];

                          // get the data
                          String bTtitle = budgets['title'];
                          int bAmount = budgets['amount'];
                          DateTime bDate = budgets['date'];

                          // return as a list tile
                          return Card(
                            elevation: 3.0,
                            color: Colors.grey.shade300,
                            child: ListTile(
                              title: Text(bTtitle),
                              subtitle: Text(bAmount.toString()),
                              trailing: Text(bDate.toString()),
                            ),
                          );
                        },
                      ),
                    );
                  }
                  return const CircularProgressIndicator();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
