import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spendwise/services/budget_firebase/budget_item_two.dart';
import 'package:spendwise/core/constants/date_time_helper.dart';
import 'package:spendwise/services/models/budgets/budget_data.dart';

class BudgetAmount extends StatelessWidget {
  const BudgetAmount({Key? key, required this.startOfWeek}) : super(key: key);
  final DateTime startOfWeek;

  String calculateDaysTotal(CloudBudgetItemTwo value) {
    List<int> values = [
      value.amount,
    ];
    int total = 0;
    for (int i = 0; i < values.length; i++) {
      total += values[i];
    }
    return total.toStringAsFixed(3);
  }

  String calculateWeekTotal(
    BudgetData value,
    String sunday,
    String monday,
    String tuesday,
    String wednesday,
    String thursday,
    String friday,
    String saturday,
  ) {
    List<double> values = [
      value.calculateDailyBudgetSummary()[sunday] ?? 0,
      value.calculateDailyBudgetSummary()[monday] ?? 0,
      value.calculateDailyBudgetSummary()[tuesday] ?? 0,
      value.calculateDailyBudgetSummary()[wednesday] ?? 0,
      value.calculateDailyBudgetSummary()[thursday] ?? 0,
      value.calculateDailyBudgetSummary()[friday] ?? 0,
      value.calculateDailyBudgetSummary()[saturday] ?? 0,
    ];

    double total = 0;
    for (int i = 0; i < values.length; i++) {
      total += values[i];
    }
    return total.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    String sunday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 0)));
    String monday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 1)));
    String tuesday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 2)));
    String wednesday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 3)));
    String thursday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 4)));
    String friday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 5)));
    String saturday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 6)));
    return Consumer<BudgetData>(
      builder: (context, value, child) {
        return Text(
          '#${calculateWeekTotal(
            value,
            sunday,
            monday,
            tuesday,
            wednesday,
            thursday,
            friday,
            saturday,
          )}',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        );
      },
    );
  }
}
