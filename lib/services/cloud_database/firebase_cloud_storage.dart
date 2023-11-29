import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spendwise/services/cloud_database/cloud_storage.dart';
import 'package:spendwise/services/cloud_database/cloud_storage_exceptions.dart';
import 'package:spendwise/services/cloud_database/cloud_constants.dart';

class FirebaseCloudStorage {
  final database = FirebaseFirestore.instance.collection('SpendwiseDB');

  // function to create
  Future<CloudDatabase> createNewExpense({required String ownerUserId}) async {
    final document = await database.add({
      ownerUserIdFieldName: ownerUserId,
      titleFieldName: '',
      amountFieldName: '',
      tagFieldName: '',
      whenFieldName: '',
      noteFieldName: '',
      transactionTypeFieldName: '',
    });

    final fetchedData = await document.get();
    return CloudDatabase(
      documentId: fetchedData.id,
      ownerUserId: ownerUserId,
      title: '',
      amount: '',
      transactionType: '',
      tag: '',
      when: '',
      note: '',
    );
  }

  // function to read/get
  Future<Iterable<CloudDatabase>> getExpense(
      {required String ownerUserId}) async {
    try {
      return await database
          .where(
            ownerUserIdFieldName,
            isEqualTo: ownerUserId,
          )
          .get()
          .then(
            (value) => value.docs.map(
              (doc) => CloudDatabase.fromSnapshot(doc),
            ),
          );
    } catch (e) {
      throw CouldNotGetAllDataException();
    }
  }

  // funtion to get a stream of data
  Stream<Iterable<CloudDatabase>> allExpense({required String ownerUserId}) =>
      database.snapshots().map(
            (event) => event.docs
                .map((doc) => CloudDatabase.fromSnapshot(doc))
                .where((expense) => expense.ownerUserId == ownerUserId),
          );

  // function to update
  Future<void> updateExpense(
      {required String documentId,
      required String title,
      required String amount,
      required String transactionType,
      required String tag,
      required String when,
      required String note}) async {
    try {
      await database.doc(documentId).update({
        titleFieldName: title,
        amountFieldName: amount,
        transactionTypeFieldName: transactionType,
        tagFieldName: tag,
        whenFieldName: when,
        noteFieldName: note,
      });
    } catch (e) {
      throw CouldNotUpdateDataException();
    }
  }

  // function to delete
  Future<void> deleteExpense({required String documentId}) async {
    try {
      await database.doc(documentId).delete();
    } catch (e) {
      throw CouldNotDeleteDataException();
    }
  }

  // singleton function
  static final FirebaseCloudStorage _shared =
      FirebaseCloudStorage._sharedInstance();
  FirebaseCloudStorage._sharedInstance();
  factory FirebaseCloudStorage() => _shared;
}
