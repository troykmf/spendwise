import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spendwise/new_youtube/app_icons.dart';
// import 'package:spendwise/services/auth/auth_service.dart';
import 'package:spendwise/new_youtube/transactions_card.dart';

class TransactionCard extends StatelessWidget {
  TransactionCard({super.key});

  final appIcons = Appicons();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(children: [
            const Row(
              children: [
                Text(
                  'Recent Transactions',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            RecentTransactionList(),
          ]),
        ));
  }
}

class RecentTransactionList extends StatelessWidget {
  RecentTransactionList({super.key});

  // final userId = AuthService.firebase().currentUser!.id;
  final userId = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection('transaction')
            .orderBy('timestamp', descending: true)
            .limit(20)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('Loading...');
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No transactoin found'));
          }
          var data = snapshot.data!.docs;
          return ListView.builder(
            shrinkWrap: true,
            itemCount: data.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              var cardData = data[index];
              return TransactionsCard(
                data: cardData,
              );
            },
          );
        });
  }
}
