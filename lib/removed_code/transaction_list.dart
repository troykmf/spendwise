import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:spendwise/new_youtube/transactions_card.dart';

class TransactionList extends StatelessWidget {
  TransactionList(
      {super.key,
      required this.category,
      required this.type,
      required this.monthYear});

  final userId = FirebaseAuth.instance.currentUser!.uid;
  final String category;
  final String type;
  final String monthYear;
  @override
  Widget build(BuildContext context) {
    Query query = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('transaction')
        .orderBy('timestamp', descending: false)
        .where('monthyear', isEqualTo: monthYear)
        .where('type', isEqualTo: type);

    if (category != 'All') {
      query = query.where('category', isEqualTo: category);
    }

    return FutureBuilder<QuerySnapshot>(
        future: query.limit(150).get(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('Loading...');
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No transaction found'));
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
