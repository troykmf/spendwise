// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:spendwise/models/budgets/budget_constants.dart';

class BudgetItem {
  final String amount;
  final DateTime datetime;

  const BudgetItem({
    required this.amount,
    required this.datetime,
  });
}
