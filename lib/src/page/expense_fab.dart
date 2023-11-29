import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spendwise/services/cloud_database/cloud_storage.dart';
import 'package:spendwise/core/constants/constant_widgets/apptextfield.dart';
import 'package:spendwise/services/models/expense/expense_data.dart';

class ExpenseFabPage extends StatefulWidget {
  const ExpenseFabPage({super.key});

  @override
  State<ExpenseFabPage> createState() => _ExpenseFabPageState();
}

class _ExpenseFabPageState extends State<ExpenseFabPage> {
  late final TextEditingController _titleController;
  late final TextEditingController _amountController;
  late final TextEditingController _tagController;
  late final TextEditingController _transactionTypeController;
  late final TextEditingController _noteController;

  @override
  void initState() {
    Provider.of<ExpenseData>(context, listen: false).prepareData();
    _titleController = TextEditingController();
    _amountController = TextEditingController();
    _tagController = TextEditingController();
    _noteController = TextEditingController();
    _transactionTypeController = TextEditingController();
    super.initState();
  }

  void save() {
    if (_titleController.text.isNotEmpty &&
        _amountController.text.isNotEmpty &&
        _tagController.text.isNotEmpty &&
        _noteController.text.isNotEmpty &&
        _transactionTypeController.text.isNotEmpty) {
      CloudDatabase newExpense = CloudDatabase(
        documentId: _titleController.text,
        ownerUserId: _titleController.text,
        title: _titleController.text,
        amount: _amountController.text,
        transactionType: _transactionTypeController.text,
        tag: _tagController.text,
        when: DateTime.now().toString(),
        note: _noteController.text,
      );

      Provider.of<ExpenseData>(context, listen: false)
          .addNewExpense(newExpense);
      _titleController.clear();
      _amountController.clear();
      _tagController.clear();
      _transactionTypeController.clear();
      _noteController.clear();
      Navigator.pop(context);
    } else {
      Navigator.of(context).pop();
    }
  }

  void cancel() => Navigator.of(context).pop();

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    _tagController.dispose();
    _transactionTypeController.dispose();
    _noteController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: const Text('Expense Page'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => cancel(),
            icon: const Icon(Icons.cancel_outlined),
          ),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => save(),
      //   elevation: 3.0,
      //   backgroundColor: Colors.black,
      //   child: const Text('Save'),
      // ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              AppCustomTextField(
                autoFocus: true,
                obscureText: false,
                autoCorrect: true,
                controller: _titleController,
                hintText: 'e.g Bags',
                textInputType: TextInputType.text,
              ),
              const SizedBox(height: 15),
              AppCustomTextField(
                autoFocus: false,
                obscureText: false,
                autoCorrect: true,
                controller: _amountController,
                hintText: 'Enter expense',
                textInputType: TextInputType.number,
              ),
              const SizedBox(height: 15),
              AppCustomTextField(
                autoFocus: false,
                obscureText: false,
                autoCorrect: true,
                controller: _transactionTypeController,
                hintText: 'Enter expense',
                textInputType: TextInputType.text,
              ),
              const SizedBox(height: 15),
              AppCustomTextField(
                autoFocus: false,
                obscureText: false,
                autoCorrect: true,
                controller: _tagController,
                hintText: 'Enter expense',
                textInputType: TextInputType.text,
              ),
              const SizedBox(height: 15),
              AppCustomTextField(
                autoFocus: false,
                obscureText: false,
                autoCorrect: true,
                controller: _noteController,
                hintText: 'Enter expense',
                textInputType: TextInputType.text,
              ),
              const SizedBox(
                height: 20,
              ),
              AppButton(
                onTap: () {
                  save();
                },
                text: 'Save',
              )
            ],
          ),
        ),
      ),
    );
  }
}
