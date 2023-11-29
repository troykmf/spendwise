import 'package:hive_flutter/adapters.dart';
import 'package:spendwise/services/cloud_database/cloud_storage.dart';

class ExpenseHiveDatabase {
  final _myBox = Hive.box('expense_database');

  // write data
  void saveData(List<CloudDatabase> allBudget) {
    List<List<dynamic>> allExpenseFormatted = [];
    for (var budget in allBudget) {
      List<dynamic> expenseFormatted = [
        budget.title,
        budget.amount,
        budget.when,
        budget.transactionType,
        budget.note,
        budget.documentId,
        budget.ownerUserId,
        budget.tag,
      ];
      allExpenseFormatted.add(expenseFormatted);
    }
    _myBox.put('ALL_EXPENSE', allExpenseFormatted);
  }

  // read the data from database
  List<CloudDatabase> readData() {
    List savedBudgets = _myBox.get('ALL_EXPENSE') ?? [];
    List<CloudDatabase> allBudget = [];
    for (int i = 0; i < savedBudgets.length; i++) {
      String title = savedBudgets[i][0];
      String amount = savedBudgets[i][1];
      DateTime dateTime = savedBudgets[i][2];
      String transactionType = savedBudgets[i][3];
      String note = savedBudgets[i][5];
      String documentId = savedBudgets[i][6];
      String pwnerUserId = savedBudgets[i][7];
      String tag = savedBudgets[i][8];

      // create expense item
      CloudDatabase expnese = CloudDatabase(
        documentId: documentId,
        ownerUserId: pwnerUserId,
        title: title,
        amount: amount,
        transactionType: transactionType,
        when: dateTime.toString(),
        tag: tag,
        note: note,
      );
      allBudget.add(expnese);
    }

    return allBudget;
  }

  void deleteData() {
    List savedExpense = _myBox.get('ALL_EXPENSE');
    for (int i in savedExpense) {
      _myBox.deleteAt(i);
    }
  }
}
