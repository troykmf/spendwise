import 'package:flutter/material.dart';
import 'package:spendwise/services/budget_firebase/budget_item_two.dart';
import 'package:spendwise/services/budget_firebase/firebase_budget_storage_two.dart';
import 'package:spendwise/core/constants/route.dart';
import 'package:spendwise/src/listview_bulder/budget_list_view.dart';

class BudgetTab extends StatelessWidget {
  BudgetTab({super.key, required this.userId});
  final userId;

  final FirebaseBudgetStorageTwo _budgetTwoService = FirebaseBudgetStorageTwo();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _budgetTwoService.allBudgetTwo(ownerUserId: userId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData) {
            final allBudget = snapshot.data as Iterable<CloudBudgetItemTwo>;
            return SizedBox(
              child: BudgetListView(
                budgetTwoDb: allBudget,
                onDeleteDetail: (bugetTwo) async {
                  await _budgetTwoService.deleteExpense(
                    budgetDocumentId: bugetTwo.documnetId,
                  );
                },
                onTap: (bugetTwo) {
                  Navigator.of(context).pushNamed(
                    budgetTwoFabRoute,
                    arguments: bugetTwo,
                  );
                },
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
