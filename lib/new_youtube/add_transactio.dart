import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:spendwise/new_youtube/app_icons.dart';
import 'package:spendwise/new_youtube/categorydropdown.dart';
import 'package:spendwise/new_youtube/database.dart';
import 'package:spendwise/services/auth/auth_service.dart';
import 'package:spendwise/services/models/budgets/budget_data.dart';
import 'package:spendwise/services/models/budgets/budget_item.dart';
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

  void save() {
    BudgetItem newBudget = BudgetItem(
      amount: amountTextEditingController.text,
      datetime: DateTime.now(),
    );

    Provider.of<BudgetData>(context, listen: false).addNewBudget(newBudget);
  }

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
  }

  void cancel() => Navigator.of(context).pop();

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
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    elevation: 3.0,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 8.0),
                  ),
                  onPressed: () {
                    if (titleTextEditingController.text.isNotEmpty &&
                        amountTextEditingController.text.isNotEmpty) {
                      _submitForm();
                      save();

                      Navigator.pop(context);
                    } else {
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Save'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    elevation: 3.0,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 8.0),
                  ),
                  onPressed: () {
                    cancel();
                  },
                  child: const Text('Cancel'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
