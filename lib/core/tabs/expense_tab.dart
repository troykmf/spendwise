import 'package:flutter/material.dart';
import 'package:spendwise/services/cloud_database/cloud_storage.dart';
import 'package:spendwise/services/cloud_database/firebase_cloud_storage.dart';
import 'package:spendwise/core/constants/route.dart';
import 'package:spendwise/src/transaction_details/transaction_detail_listview.dart';

class ExpenseTab extends StatelessWidget {
  ExpenseTab({super.key, required this.userId});

  final userId;

  final FirebaseCloudStorage _cloudStorageService = FirebaseCloudStorage();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _cloudStorageService.allExpense(ownerUserId: userId),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const CircularProgressIndicator();

          case ConnectionState.active:
            if (snapshot.hasData) {
              final allTransactionDetail =
                  snapshot.data as Iterable<CloudDatabase>;
              return SizedBox(
                child: TransactoinDetailListView(
                  database: allTransactionDetail,
                  onDeleteDetail: (detail) async {
                    await _cloudStorageService.deleteExpense(
                      documentId: detail.documentId,
                    );
                  },
                  onTap: (detail) {
                    Navigator.of(context).pushNamed(
                      fabRoute,
                      arguments: detail,
                    );
                  },
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }

          default:
            return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
