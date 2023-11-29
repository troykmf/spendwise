import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spendwise/services/auth/auth_service.dart';

class FirebaseBudgetStorage {
  // current logged in user
  final user = AuthService.firebase().currentUser;

  // get collection of budget from firebase
  final CollectionReference budget =
      FirebaseFirestore.instance.collection('Budget');

  // post a budget
  Future<void> addBudget(String title, int amount) async {
    await budget.add({
      'UserEmail': user!.email,
      'title': title,
      'amount': amount,
      'date': DateTime.now(),
    });
    // return budgetAdd;
  }

  // read budget from database
  Stream<QuerySnapshot> getBudgetStream() {
    final budgetStream =
        budget.orderBy('dateTime', descending: true).snapshots();
    return budgetStream;
  }
}
