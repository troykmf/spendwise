import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:spendwise/services/cloud_database/cloud_storage.dart';
import 'package:spendwise/services/models/expense/expense_data.dart';

typedef TransactionDetailCallBack = void Function(CloudDatabase database);

class TransactoinDetailListView extends StatelessWidget {
  final Iterable<CloudDatabase> database;
  final TransactionDetailCallBack onDeleteDetail;
  final TransactionDetailCallBack onTap;
  const TransactoinDetailListView({
    super.key,
    required this.database,
    required this.onDeleteDetail,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    void deleteExpense(CloudDatabase expense) {
      Provider.of<ExpenseData>(context, listen: false).deleteExpense(expense);
    }

    return Consumer<ExpenseData>(
      builder: (context, value, child) {
        return ListView.separated(
          separatorBuilder: (context, index) {
            return const Divider(
              indent: 1.0,
              endIndent: 1.0,
            );
          },
          itemCount: database.length,
          itemBuilder: (context, index) {
            final transactionDetail = database.elementAt(index);
            return Slidable(
              endActionPane: ActionPane(
                motion: const StretchMotion(),
                children: [
                  SlidableAction(
                    onPressed: (onPressed) {
                      onDeleteDetail(transactionDetail);
                      deleteExpense(value.getAllExpesneItemList()[index]);
                    },
                    icon: Icons.delete,
                    backgroundColor: Colors.red,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ],
              ),
              child: GestureDetector(
                onTap: () {
                  onTap(transactionDetail);
                },
                child: Container(
                  height: 70,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              // value.getAllExpesneItemList()[index].title,
                              transactionDetail.title,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17.0,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(transactionDetail.tag),
                          ],
                        ),
                      ),
                      Container(),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              // value.getAllExpesneItemList()[index].amount,
                              transactionDetail.amount,
                              style: const TextStyle(
                                color: Colors.green,
                                fontSize: 17.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              transactionDetail.when,
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

// Container(
//           height: 50,
//           width: double.infinity,
//           child: Row(
//             children: [
//               Column(
//                 children: [
//                   Text(
//                     transactionDetail.title,
//                     style: const TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 17.0,
//                     ),
//                   ),
//                   Text(transactionDetail.tag),
//                 ],
//               ),
//               Column(
//                 children: [
//                   Text(
//                     '#${transactionDetail.amount}',
//                     style: const TextStyle(
//                       color: Colors.green,
//                       fontSize: 17.0,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   Text(transactionDetail.when),
//                 ],
//               ),
//               IconButton(
//                 onPressed: () {
//                   onDeleteDetail(transactionDetail);
//                 },
//                 icon: const Icon(CupertinoIcons.delete),
//               ),
//             ],
//           ),
//         );
