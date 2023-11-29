import 'package:flutter/material.dart';
import 'package:spendwise/src/bar_graph/bar_graph.dart';
import 'package:spendwise/core/constants/date_time_helper.dart';
import 'package:spendwise/services/models/budgets/budget_data.dart';
import 'package:provider/provider.dart';

class BudgetSummary extends StatelessWidget {
  const BudgetSummary({super.key, required this.startOfWeek});

  final DateTime startOfWeek;

  double calculateMax(
    BudgetData value,
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
      value.calculateDailyBudgetSummary()[sunday] ?? 0,
      value.calculateDailyBudgetSummary()[monday] ?? 0,
      value.calculateDailyBudgetSummary()[tuesday] ?? 0,
      value.calculateDailyBudgetSummary()[wednesday] ?? 0,
      value.calculateDailyBudgetSummary()[thursday] ?? 0,
      value.calculateDailyBudgetSummary()[friday] ?? 0,
      value.calculateDailyBudgetSummary()[saturday] ?? 0,
    ];

    // sort from smallest to largest

    values.sort();

    max = values.last * 1.1;

    return max;
  }

  // calculate the weeks total
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
                  sunAmount: value.calculateDailyBudgetSummary()[sunday] ?? 0,
                  monAmount: value.calculateDailyBudgetSummary()[monday] ?? 0,
                  tueAmount: value.calculateDailyBudgetSummary()[tuesday] ?? 0,
                  wedAmount:
                      value.calculateDailyBudgetSummary()[wednesday] ?? 0,
                  thuAmount: value.calculateDailyBudgetSummary()[thursday] ?? 0,
                  friAmount: value.calculateDailyBudgetSummary()[friday] ?? 0,
                  satAmount: value.calculateDailyBudgetSummary()[saturday] ?? 0,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
