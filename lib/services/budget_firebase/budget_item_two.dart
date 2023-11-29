import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spendwise/services/budget_firebase/cloud_budget_constants.dart';

class CloudBudgetItemTwo {
  final String documnetId;
  final String ownerUserId;
  final String title;
  final int amount;
  final String dropItem;
  final Timestamp dateTime;

  CloudBudgetItemTwo({
    required this.documnetId,
    required this.ownerUserId,
    required this.title,
    required this.amount,
    required this.dropItem,
    required this.dateTime,
  });

  CloudBudgetItemTwo.fromSnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : documnetId = snapshot.id,
        ownerUserId = snapshot.data()[ownerBudgetUserIdFieldName] as String,
        title = snapshot.data()[titleBudgetFieldName] as String,
        amount = snapshot.data()[amountBudgetFieldName] as int,
        dateTime = snapshot.data()[dateTimeBudgetName] as Timestamp,
        dropItem = snapshot.data()[dropItemFieldName] as String;
}
