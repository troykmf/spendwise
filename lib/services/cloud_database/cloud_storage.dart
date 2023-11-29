import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spendwise/services/cloud_database/cloud_constants.dart';

class CloudDatabase {
  final String documentId;
  final String ownerUserId;
  final String title;
  final String amount;
  final String transactionType;
  final String tag;
  final String when;
  final String note;

  CloudDatabase({
    required this.documentId,
    required this.ownerUserId,
    required this.title,
    required this.amount,
    required this.transactionType,
    required this.tag,
    required this.when,
    required this.note,
  });

  CloudDatabase.fromSnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : documentId = snapshot.id,
        ownerUserId = snapshot.data()[ownerUserIdFieldName],
        title = snapshot.data()[titleFieldName] as String,
        amount = snapshot.data()[amountFieldName] as String,
        transactionType = snapshot.data()[transactionTypeFieldName] as String,
        tag = snapshot.data()[tagFieldName] as String,
        when = snapshot.data()[whenFieldName] as String,
        note = snapshot.data()[noteFieldName] as String;
}
