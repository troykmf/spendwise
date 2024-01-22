import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

// class FirebaseApi {
//   final _firebaseMessaging = FirebaseMessaging.instance;
//   Future<void> initNotification() async {
//     await _firebaseMessaging.requestPermission();
//
//     final fCMToken = await _firebaseMessaging.getToken();
//
//     await _firebaseMessaging.setAutoInitEnabled(true);
//     print('Token: $fCMToken');
//   }
// }

class FirebasePushNotificationApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotification() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    RemoteMessage message = RemoteMessage();
    print('User grnated permission: ${settings.authorizationStatus}');

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });

    _firebaseMessagingBackgroundHandler(message);
  }

  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    await Firebase.initializeApp();

    print('Handling a background message: ${message.messageId}');
  }
}

class AuthService2 {
  final CollectionReference addUser =
      FirebaseFirestore.instance.collection('addUser');

  Future<void> addUsers(data, context) async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    await addUser
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

  // Stream<DocumentSnapshot> getDOc() {
  //   await addUser.doc().get().snapshot;
  // }
}
