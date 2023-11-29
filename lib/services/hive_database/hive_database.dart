import 'package:hive_flutter/adapters.dart';
import 'package:spendwise/services/models/budgets/budget_item.dart';

class HiveDatabase {
  final _myBox = Hive.box('budget_database');

  // write data
  void saveData(List<BudgetItem> allBudget) {
    List<List<dynamic>> allBudgetFormatted = [];
    for (var budget in allBudget) {
      List<dynamic> budgetFormatted = [
        budget.title,
        budget.amount,
        budget.datetime,
      ];
      allBudgetFormatted.add(budgetFormatted);
    }
    _myBox.put('ALL_BUDGET', allBudgetFormatted);
  }

  // read the data from database
  List<BudgetItem> readData() {
    List savedBudgets = _myBox.get('ALL_BUDGET') ?? [];
    List<BudgetItem> allBudget = [];
    for (int i = 0; i < savedBudgets.length; i++) {
      String title = savedBudgets[i][0];
      String amount = savedBudgets[i][1];
      DateTime dateTime = savedBudgets[i][2];

      // create budget item
      BudgetItem budget = BudgetItem(
        title: title,
        amount: amount,
        datetime: dateTime,
      );
      allBudget.add(budget);
    }

    return allBudget;
  }

  void deleteData() {
    List savedBudget = _myBox.get('ALL_BUDGET');
    for (int i in savedBudget) {
      _myBox.deleteAt(i);
    }
  }
}
