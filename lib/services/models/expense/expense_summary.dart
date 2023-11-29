import 'package:flutter/material.dart';
import 'package:spendwise/src/bar_graph/bar_graph.dart';
import 'package:spendwise/core/constants/date_time_helper.dart';
import 'package:provider/provider.dart';
import 'package:spendwise/services/models/expense/expense_data.dart';

class ExpenseSummary extends StatelessWidget {
  const ExpenseSummary({super.key, required this.startOfWeek});

  final DateTime startOfWeek;

  double calculateMax(
    ExpenseData value,
    String sunday,
    String monday,
    String tuesday,
    String wednesday,
    String thursday,
    String friday,
    String saturday,
  ) {
    double max = 1000000;
    List<double> values = [
      value.calculateDailyExpenseSummary()[sunday] ?? 0,
      value.calculateDailyExpenseSummary()[monday] ?? 0,
      value.calculateDailyExpenseSummary()[tuesday] ?? 0,
      value.calculateDailyExpenseSummary()[wednesday] ?? 0,
      value.calculateDailyExpenseSummary()[thursday] ?? 0,
      value.calculateDailyExpenseSummary()[friday] ?? 0,
      value.calculateDailyExpenseSummary()[saturday] ?? 0,
    ];

    // sort from smallest to largest

    values.sort();

    max = values.last * 1.1;

    return max;
  }

  // calculate the weeks total
  String calculateWeekTotal(
    ExpenseData value,
    String sunday,
    String monday,
    String tuesday,
    String wednesday,
    String thursday,
    String friday,
    String saturday,
  ) {
    List<double> values = [
      value.calculateDailyExpenseSummary()[sunday] ?? 0,
      value.calculateDailyExpenseSummary()[monday] ?? 0,
      value.calculateDailyExpenseSummary()[tuesday] ?? 0,
      value.calculateDailyExpenseSummary()[wednesday] ?? 0,
      value.calculateDailyExpenseSummary()[thursday] ?? 0,
      value.calculateDailyExpenseSummary()[friday] ?? 0,
      value.calculateDailyExpenseSummary()[saturday] ?? 0,
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

    return Consumer<ExpenseData>(
      builder: (context, value, child) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
              child: SizedBox(
                width: double.infinity,
                height: 350,
                child: MyBarGraph(
                  maxY: calculateMax(value, sunday, monday, tuesday, wednesday,
                      thursday, friday, saturday),
                  sunAmount: value.calculateDailyExpenseSummary()[sunday] ?? 0,
                  monAmount: value.calculateDailyExpenseSummary()[monday] ?? 0,
                  tueAmount: value.calculateDailyExpenseSummary()[tuesday] ?? 0,
                  wedAmount:
                      value.calculateDailyExpenseSummary()[wednesday] ?? 0,
                  thuAmount:
                      value.calculateDailyExpenseSummary()[thursday] ?? 0,
                  friAmount: value.calculateDailyExpenseSummary()[friday] ?? 0,
                  satAmount:
                      value.calculateDailyExpenseSummary()[saturday] ?? 0,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
