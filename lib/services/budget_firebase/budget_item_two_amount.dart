// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:spendwise/services/auth/auth_service.dart';

// class Db {
//   CollectionReference users =
//       FirebaseFirestore.instance.collection('BudgetTwo');
//   final userId = AuthService.firebase().currentUser!.id;

//   Future<void> addData() async {
//     await users.doc(userId).set({
//       'title': '',
//       'amount': 0,
//     }).then((value) => null)
//   }
// }


