import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:spendwise/new_youtube/app_icons.dart';
import 'package:spendwise/new_youtube/categorydropdown.dart';
import 'package:spendwise/new_youtube/database.dart';
import 'package:uuid/uuid.dart';

class AddTransactionForm extends StatefulWidget {
  const AddTransactionForm({super.key});

  @override
  State<AddTransactionForm> createState() => _AddTransactionFormState();
}

class _AddTransactionFormState extends State<AddTransactionForm> {
  var amountTextEditingController = TextEditingController();
  var titleTextEditingController = TextEditingController();
  final appIcons = Appicons();
  var type = 'credit';
  var category = 'Others';
  var uid = const Uuid();
  final db = Db();

  Future<void> _submitForm() async {
    final user = FirebaseAuth.instance.currentUser;
    int timestamp = DateTime.now().millisecondsSinceEpoch;
    var amount = int.parse(amountTextEditingController.text);
    DateTime date = DateTime.now();

    var id = uid.v4();
    String monthyear = DateFormat('MMM y').format(date);

    final userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get();

    int remainingAmount = userDoc['remainingAmount'];
    int totalCredit = userDoc['totalCredit'];
    int totalDebit = userDoc['totalDebit'];

    if (type == 'credit') {
      remainingAmount += amount;
      totalCredit += amount;
    } else {
      remainingAmount -= amount;
      totalDebit += amount;
    }

    await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
      'remainingAmount': remainingAmount,
      'totalCredit': totalCredit,
      'totalDebit': totalDebit,
      'updatedAt': timestamp,
    });

    var anotherData = {
      'id': id,
      'title': titleTextEditingController.text,
      'amount': amount,
      'type': type,
      'timestamp': timestamp,
      'totalCredit': totalCredit,
      'totalDebit': totalDebit,
      'remainingAmount': remainingAmount,
      'monthyear': monthyear,
      'category': category,
    };

    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('transaction')
        .doc(id)
        .set(anotherData);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: titleTextEditingController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextFormField(
              controller: amountTextEditingController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Amount'),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField(
              value: type,
              items: const [
                DropdownMenuItem(
                  value: 'credit',
                  child: Text('Budget'),
                ),
                DropdownMenuItem(
                  value: 'debit',
                  child: Text('Expense'),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  type = value!;
                });
              },
            ),
            CategoryDropdown(
              cattype: category,
              onchanged: (String? value) {
                setState(() {
                  category = value!;
                });
              },
            ),
            ElevatedButton(
              onPressed: () {
                _submitForm();
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
