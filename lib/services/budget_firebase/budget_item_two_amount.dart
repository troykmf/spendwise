// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:spendwise/budget_firebase/budget_item_two.dart';
// import 'package:spendwise/constants/date_time_helper.dart';

// class BudgetItemTwoAmount extends StatelessWidget {
//   const BudgetItemTwoAmount({super.key});

//   Map<String, double> calculateDailyBudgetSummary() {
//     Map<String, double> dailyBudgetSummary = {};
//     List<CloudBudgetItemTwo> value = [];

//     for (var budget in value) {
//       String date = convertDateTimeToString(budget.dateTime.toDate());
//       int amount = budget.amount;

//       if (dailyBudgetSummary.containsKey(date)) {
//         double currentAmount = dailyBudgetSummary[date]!;
//         currentAmount += amount;
//         dailyBudgetSummary[date] = currentAmount;
//       } else {
//         dailyBudgetSummary.addAll({date: double.parse(amount.toString())});
//       }
//     }
//     return dailyBudgetSummary;
//   }

//   String calculateDaysTotal({required final CloudBudgetItemTwo value}) {
//     List<int> values = [
//       value.amount,
//     ];
//     int total = 0;
//     for (int i = 0; i < values.length; i++) {
//       total += values[i];
//     }
//     return total.toStringAsFixed(3);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Text('#$calculateDaysTotal()');
//   }
// }
