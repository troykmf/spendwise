// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:spendwise/services/budget_firebase/firebase_budget_storage_two.dart';
import 'package:spendwise/core/constants/date_time_helper.dart';
import 'package:spendwise/services/hive_database/hive_database.dart';
import 'package:spendwise/services/models/budgets/budget_item.dart';

class BudgetData extends ChangeNotifier {
  // final CollectionReference database =
  //     FirebaseFirestore.instance.collection('users');
  List<BudgetItem> overAllBudgetList = [];

  // get budget list
  List<BudgetItem> getAllBudgetItemList() {
    return overAllBudgetList;
  }

  // prepare data to display
  final databaseService = FirebaseBudgetStorageTwo();
  final db = HiveDatabase();
  void prepareData() {
    if (db.readData().isNotEmpty) {
      overAllBudgetList = db.readData();
    }
  }

  // add new budget
  void addNewBudget(BudgetItem newBudget) {
    overAllBudgetList.add(newBudget);

    notifyListeners();
    db.saveData(overAllBudgetList);
  }

  // delete budget
  void deleteBudget(BudgetItem budget) {
    overAllBudgetList.remove(budget);

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

  Map<String, double> calculateDailyBudgetSummary() {
    Map<String, double> dailyBudgetSummary = {};

    for (var budget in overAllBudgetList) {
      String date = convertDateTimeToString(budget.datetime);
      double amount = double.parse(budget.amount);

      if (dailyBudgetSummary.containsKey(date)) {
        double currentAmount = dailyBudgetSummary[date]!;
        currentAmount += amount;
        dailyBudgetSummary[date] = currentAmount;
      } else {
        dailyBudgetSummary.addAll({date: amount});
      }
    }
    return dailyBudgetSummary;
  }

  // for monthly bar chart

  String getMonthName(DateTime dateTime) {
    switch (dateTime.month) {
      case 1:
        return 'Jan';

      case 2:
        return 'Feb';

      case 3:
        return 'Mar';

      case 4:
        return 'Apr';

      case 5:
        return 'May';

      case 6:
        return 'Jun';

      case 7:
        return 'Jul';

      case 8:
        return 'Aug';

      case 9:
        return 'Sep';

      case 10:
        return 'Oct';

      case 11:
        return 'Nov';

      case 12:
        return 'Dec';

      default:
        return '';
    }
  }

  // calculate total expenses for each month
  Future<Map<int, double>> calculateMonthlyTotals() async {
    // ensure data is read from the db
    getAllBudgetItemList();

    //  crreate a mapm to keep track of all expenses
    Map<int, double> monthlyTotals = {};

    // iterate over all expenses
    for (var monthlyBudget in overAllBudgetList) {
      // extract month from the date of expense
      int month = monthlyBudget.datetime.month;

      // if month us not yet in the map, initialize to 0
      if (!monthlyTotals.containsKey(month)) {
        monthlyTotals[month] = 0;
      }

      int amount = int.parse(monthlyBudget.amount);
      // add the budget to the monthlyTotal
      monthlyTotals[month] = monthlyTotals[month]! + amount;
    }

    return monthlyTotals;
  }

  // get start month
  int getStartMonth() {
    if (overAllBudgetList.isEmpty) {
      return DateTime.now().month;
    }
    // start budget by date to find the earliest
    overAllBudgetList.sort(
      (a, b) => a.datetime.compareTo(b.datetime),
    );
    return overAllBudgetList.first.datetime.month;
  }

  // get start year
  int getStartYear() {
    if (overAllBudgetList.isEmpty) {
      return DateTime.now().year;
    }

    // start budget by date to find the earliest
    overAllBudgetList.sort(
      (a, b) => a.datetime.compareTo(b.datetime),
    );

    return overAllBudgetList.first.datetime.year;
  }
}
