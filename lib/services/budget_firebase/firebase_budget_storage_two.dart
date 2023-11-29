import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:spendwise/services/budget_firebase/budget_item_two.dart';
import 'package:spendwise/services/budget_firebase/cloud_budget_constants.dart';
import 'package:spendwise/services/cloud_database/cloud_constants.dart';
import 'package:spendwise/services/models/budgets/budget_exception.dart';

class FirebaseBudgetStorageTwo extends ChangeNotifier {
  // call the collection
  final budgetDb = FirebaseFirestore.instance.collection('BudgetTwo');

  // create db
  Future<CloudBudgetItemTwo> createBudgetTwo({
    required String ownerUserId,
    required String selectedItem,
    required String title,
    required int amount,
  }) async {
    final budgetDocument = await budgetDb.add({
      ownerBudgetUserIdFieldName: ownerUserId,
      titleBudgetFieldName: title,
      amountFieldName: amount,
      dateTimeBudgetName: Timestamp.fromDate(DateTime.now()).toDate(),
      dropItemFieldName: selectedItem,
    });

    final fetchedBudgetDocument = await budgetDocument.get();
    return CloudBudgetItemTwo(
      documnetId: fetchedBudgetDocument.id,
      ownerUserId: ownerUserId,
      title: title,
      amount: amount,
      dropItem: selectedItem,
      dateTime: Timestamp.fromDate(DateTime.now()),
    );
  }

  // get db
  Future<Iterable<CloudBudgetItemTwo>> getBudgetTwo({
    required String owneruserId,
  }) async {
    try {
      return await budgetDb
          .where(
            ownerBudgetUserIdFieldName,
            isEqualTo: owneruserId,
          )
          .get()
          .then(
            (value) => value.docs.map(
              (docum) => CloudBudgetItemTwo.fromSnapshot(docum),
            ),
          );
    } catch (e) {
      throw CouldNotGetAllBudgetDataException();
    }
  }

  // get stream
  Stream<Iterable<CloudBudgetItemTwo>> allBudgetTwo(
          {required String ownerUserId}) =>
      budgetDb.snapshots().map(
            (snapshot) => snapshot.docs
                .map(
                  (doc) => CloudBudgetItemTwo.fromSnapshot(doc),
                )
                .where(
                  (budget) => budget.ownerUserId == ownerUserId,
                ),
          );

  // update db
  Future<void> updateBudgetTwo({
    required String budgetDocumentId,
    required String title,
    required String amount,
    required String dropItem,
  }) async {
    try {
      await budgetDb.doc(budgetDocumentId).update({
        titleBudgetFieldName: title,
        amount: amount,
        dropItemFieldName: dropItem,
      });
    } catch (e) {
      throw CouldNotUpdateBudgetDataException();
    }
  }

  // delete db
  Future<void> deleteExpense({required String budgetDocumentId}) async {
    try {
      await budgetDb.doc(budgetDocumentId).delete();
    } catch (e) {
      throw CouldNotDeleteBudgetDataException();
    }
  }

  // singleton function
  static final FirebaseBudgetStorageTwo _shared =
      FirebaseBudgetStorageTwo._sharedInstance();
  FirebaseBudgetStorageTwo._sharedInstance();
  factory FirebaseBudgetStorageTwo() => _shared;
}
