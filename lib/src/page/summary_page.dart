import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spendwise/services/models/budgets/budget_data.dart';
import 'package:spendwise/services/models/budgets/budget_summary.dart';

class SummaryPage extends StatelessWidget {
  const SummaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BudgetData>(
      builder: (context, value, child) {
        return Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.arrow_back,
                ),
              ),
              BudgetSummary(
                startOfWeek: value.startOfWeek(),
              ),
            ],
          ),
        );
      },
    );
  }
}
