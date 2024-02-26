import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:spendwise/services/auth/auth_service.dart';
import 'package:uuid/uuid.dart';

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
              title: const Text('Sign up failer error'),
              content: Text(error.toString()),
            );
          });
    });
  }

  Stream<DocumentSnapshot> getDoc({required String userId}) =>
      users.doc(userId).snapshots();

  // Future<void> deleteDoc({required String userId}) async {
  //   await users.doc(userId).collection('transaction').doc(userId).delete();
  // }

  Future<void> deleteForm() async {
    final user = AuthService.firebase().currentUser;
    var uid = const Uuid();
    var id = uid.v4();

    await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.id)
        .collection('transaction')
        .doc(id)
        .delete();
  }
}
