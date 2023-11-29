import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spendwise/services/models/budgets/budget_data.dart';
import 'package:spendwise/services/models/budgets/budget_item.dart';

class BudgetFabPage extends StatefulWidget {
  const BudgetFabPage({super.key});

  @override
  State<BudgetFabPage> createState() => _BudgetFabPageState();
}

class _BudgetFabPageState extends State<BudgetFabPage> {
  late final TextEditingController _titleController;
  late final TextEditingController _amountController;

  @override
  void initState() {
    Provider.of<BudgetData>(context, listen: false).prepareData();
    _titleController = TextEditingController();
    _amountController = TextEditingController();
    super.initState();
  }

  void save() {
    if (_titleController.text.isNotEmpty && _amountController.text.isNotEmpty) {
      BudgetItem newBudget = BudgetItem(
        title: _titleController.text,
        amount: _amountController.text,
        datetime: DateTime.now(),
      );

      Provider.of<BudgetData>(context, listen: false).addNewBudget(newBudget);
      _titleController.clear();
      _amountController.clear();
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: const Text('Budget Page'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => cancel(),
            icon: const Icon(Icons.cancel_outlined),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => save(),
        elevation: 3.0,
        backgroundColor: Colors.black,
        child: const Text('Save'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _titleController,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              hintText: 'e.g Bags',
            ),
          ),
          TextField(
            controller: _amountController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText: 'Enter your budget',
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
