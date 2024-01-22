import 'package:flutter/material.dart';
import 'package:spendwise/new_youtube/transaction_list.dart';

class TypeTabBar extends StatelessWidget {
  TypeTabBar({super.key, required this.catgeory, required this.monthyear});

  final String catgeory;
  final String monthyear;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            TabBar(
              tabs: [
                Tab(
                  text: 'credit',
                ),
                Tab(
                  text: 'debit',
                )
              ],
            ),
            Expanded(
                child: TabBarView(children: [
              TransactionList(
                category: catgeory,
                type: 'credit',
                monthyear: monthyear,
              ),
              TransactionList(
                category: catgeory,
                type: 'debit',
                monthyear: monthyear,
              ),
            ]))
          ],
        ),
      ),
    );
  }
}
