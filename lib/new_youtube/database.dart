import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:spendwise/services/auth/auth_service.dart';

class Db {
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void> addUsers(data, context) async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    await users
        .doc(userId)
        .set(data)
        .then((value) => print('user Added'))
        .catchError((error) {
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Sign up failer error'),
              content: Text(error.toString()),
            );
          });
    });
  }

  Stream<DocumentSnapshot> getDoc({required String userId}) =>
      users.doc(userId).snapshots();
}

class FirebaseDatabase {
  final CollectionReference spendData =
      FirebaseFirestore.instance.collection('user');

  Future<void> addData({required String title, required String amount}) async {
    await spendData.add({
      'title': title,
      'amount': amount,
      'totalBalance': 0,
      'totalExpense': 0,
      'totalBudget': 0,
    });
  }
}
