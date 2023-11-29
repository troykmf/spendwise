import 'package:flutter/material.dart';
import 'package:spendwise/services/cloud_database/cloud_storage.dart';
import 'package:spendwise/core/constants/date_time_helper.dart';
import 'package:spendwise/services/hive_database/expesne_database.dart';

class ExpenseData extends ChangeNotifier {
  List<CloudDatabase> overAllExpenseList = [];

  // get budget list
  List<CloudDatabase> getAllExpesneItemList() {
    return overAllExpenseList;
  }

  // prepare data to display
  final db = ExpenseHiveDatabase();
  void prepareData() {
    if (db.readData().isNotEmpty) {
      overAllExpenseList = db.readData();
    }
  }

  // add new budget
  void addNewExpense(CloudDatabase newExpense) {
    overAllExpenseList.add(newExpense);

    notifyListeners();
    db.saveData(overAllExpenseList);
  }

  // delete budget
  void deleteExpense(CloudDatabase expense) {
    overAllExpenseList.remove(expense);

    notifyListeners();
    db.deleteData();
  }

  // get weekly from datetime object
  String getDayName(DateTime dateTime) {
    switch (dateTime.weekday) {
      case 1:
        return 'Mon';

      case 2:
        return 'Tue';

      case 3:
        return 'Wed';

      case 4:
        return 'Thu';

      case 5:
        return 'Fri';

      case 6:
        return 'Sat';

      case 7:
        return 'Sun';

      default:
        return '';
    }
  }

  //  get the date for the start of the week

  DateTime startOfWeek() {
    DateTime? startOfWeek;

    // get today's date
    DateTime today = DateTime.now();

    //  go back from today to find sunday
    for (int i = 0; i < 7; i++) {
      if (getDayName(today.subtract(Duration(days: i))) == 'Sun') {
        startOfWeek = today.subtract(Duration(days: i));
      }
    }
    return startOfWeek!;
  }

  //  convert overall list of budget into a daily budget summary

  Map<String, double> calculateDailyExpenseSummary() {
    Map<String, double> dailyExpenseSummary = {};

    for (var budget in overAllExpenseList) {
      final dateTtime = budget.when;
      final daTeTime = DateTime.parse(dateTtime);
      String date = convertDateTimeToString(daTeTime);
      double amount = double.parse(budget.amount);

      if (dailyExpenseSummary.containsKey(date)) {
        double currentAmount = dailyExpenseSummary[date]!;
        currentAmount += amount;
        dailyExpenseSummary[date] = currentAmount;
      } else {
        dailyExpenseSummary.addAll({date: amount});
      }
    }
    return dailyExpenseSummary;
  }
}
