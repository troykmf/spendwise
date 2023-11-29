import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:spendwise/services/budget_firebase/budget_item_two.dart';

typedef BudgetListViewCallBack = void Function(CloudBudgetItemTwo bugetTwo);

class BudgetListView extends StatelessWidget {
  const BudgetListView({
    super.key,
    required this.budgetTwoDb,
    this.deleteTapped,
    required this.onDeleteDetail,
    required this.onTap,
  });

  final Iterable<CloudBudgetItemTwo> budgetTwoDb;
  final Function(BuildContext, BudgetListViewCallBack)? deleteTapped;
  final BudgetListViewCallBack onDeleteDetail;
  final BudgetListViewCallBack onTap;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        final budgetTwoDetail = budgetTwoDb.elementAt(index);
        String title = budgetTwoDetail.title;
        int amount = budgetTwoDetail.amount;
        String dropItem = budgetTwoDetail.dropItem;
        return Slidable(
          endActionPane: ActionPane(
            motion: const StretchMotion(),
            children: [
              SlidableAction(
                onPressed: (onPressed) {
                  onDeleteDetail(budgetTwoDetail);
                },
                icon: Icons.delete,
                backgroundColor: Colors.red,
                borderRadius: BorderRadius.circular(4),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: ListTile(
                onTap: () {
                  onTap(budgetTwoDetail);
                },
                title: Text(title),
                subtitle: Text(dropItem),
                trailing: Column(
                  children: [
                    Text(
                      amount.toString(),
                      style: const TextStyle(color: Colors.green),
                    ),
                    Text(
                      '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
                    ),
                  ],
                )),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return const Divider(
          indent: 1.0,
          endIndent: 1.0,
        );
      },
      itemCount: budgetTwoDb.length,
    );
  }
}
