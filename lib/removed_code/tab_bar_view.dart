import 'package:flutter/material.dart';
import 'package:spendwise/removed_code/transaction_list.dart';

class TypeTabBar extends StatelessWidget {
  const TypeTabBar(
      {super.key, required this.category, required this.monthyear});

  final String category;
  final String monthyear;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          const TabBar(
            tabs: [
              Tab(
                text: 'budget',
              ),
              Tab(
                text: 'expense',
              )
            ],
          ),
          // SizedBox(
          //   height: double.maxFinite,
          //   width: double.maxFinite,
          //   child: TabBarView(
          //     children: [
          //       Text('credit'),
          //       Text('debit'),
          //     ],
          //   ),
          // )

          SizedBox(
            height: double.maxFinite,
            width: double.maxFinite,
            child: TabBarView(
              children: [
                TransactionList(
                  category: category,
                  type: 'credit',
                  monthYear: monthyear,
                ),
                TransactionList(
                  category: category,
                  type: 'debit',
                  monthYear: monthyear,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
