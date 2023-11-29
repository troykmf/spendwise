import 'package:flutter/material.dart';
import 'package:spendwise/services/budget_firebase/budget_item_two.dart';
import 'package:spendwise/services/budget_firebase/firebase_budget_storage_two.dart';
import 'package:spendwise/core/constants/constant_widgets/apptextfield.dart';
import 'package:spendwise/core/constants/route.dart';
import 'package:spendwise/services/auth/auth_service.dart';
import 'package:spendwise/core/utilities/generics/get_arguments.dart';

class BudgetTwoFabPage extends StatefulWidget {
  const BudgetTwoFabPage({super.key});

  @override
  State<BudgetTwoFabPage> createState() => _BudgetTwoFabPageState();
}

class _BudgetTwoFabPageState extends State<BudgetTwoFabPage> {
  CloudBudgetItemTwo? _budgetItemTwo;
  late final FirebaseBudgetStorageTwo _budgetStorageTwoService =
      FirebaseBudgetStorageTwo();
  late final TextEditingController _budgetTitle;
  late final TextEditingController _budgetAmount;
  String selectedItem = 'Clothes';
  final dropList = [
    'Clothes',
    'Shoes',
    'Food',
    'Vacation',
    'Transportation',
    'Others'
  ];

  @override
  void initState() {
    _budgetTitle = TextEditingController();
    _budgetAmount = TextEditingController();
    super.initState();
  }

  // void _textControllerListener() async {
  //   final budgetDatabase = _budgetItemTwo;
  //   if (budgetDatabase == null) {
  //     return;
  //   }
  //   final title = _budgetTitle.text;
  //   final amount = _budgetAmount.text;
  //   final selectDropItem = selectedItem;

  //   await _budgetStorageTwoService.updateBudgetTwo(
  //     budgetDocumentId: budgetDatabase.documnetId,
  //     title: title,
  //     amount: amount,
  //     dropItem: selectDropItem,
  //   );
  // }

  // void _setupTextControllerListener() {
  //   _budgetTitle.removeListener(_textControllerListener);
  //   _budgetTitle.addListener(_textControllerListener);

  //   _budgetAmount.removeListener(_textControllerListener);
  //   _budgetAmount.addListener(_textControllerListener);
  // }

  Future<CloudBudgetItemTwo> createBudget2() async {
    final existingBudget = _budgetItemTwo;
    if (existingBudget != null) {
      return existingBudget;
    }

    final title = _budgetTitle.text;
    final amount = _budgetAmount.text;
    final currentUser = AuthService.firebase().currentUser!.id;
    final newBudget = await _budgetStorageTwoService.createBudgetTwo(
      ownerUserId: currentUser,
      selectedItem: selectedItem,
      title: title,
      amount: int.parse(amount),
    );

    if (title.isNotEmpty && amount.isNotEmpty) {
      newBudget;
    }
    return newBudget;
  }

  Future<CloudBudgetItemTwo> createBudget(BuildContext context) async {
    final widgetBudget = context.getArgument<CloudBudgetItemTwo>();
    int amount = int.parse(_budgetAmount.text);
    if (widgetBudget != null) {
      _budgetItemTwo = widgetBudget;
      amount = widgetBudget.amount;
      _budgetTitle.text = widgetBudget.title;
      selectedItem = widgetBudget.dropItem;
      return widgetBudget;
    }

    final existingBudget = _budgetItemTwo;
    if (existingBudget != null) {
      return existingBudget;
    }
    final currentUser = AuthService.firebase().currentUser!;
    final userId = currentUser.id;
    final newBudget = await _budgetStorageTwoService.createBudgetTwo(
      selectedItem: selectedItem,
      ownerUserId: userId,
      title: _budgetTitle.text,
      amount: amount,
    );
    return newBudget;
  }

  Future<void> updateBudget() async {
    final widgetBudget = context.getArgument();
    final title = _budgetTitle.text;
    final amount = _budgetAmount.text;
    if (widgetBudget != null && title.isNotEmpty && amount.isNotEmpty) {
      await _budgetStorageTwoService.updateBudgetTwo(
        budgetDocumentId: widgetBudget.documnetId,
        title: title,
        amount: amount,
        dropItem: selectedItem,
      );
    }
  }

  Future<void> _deleteBudget() async {
    final budgetDb = _budgetItemTwo;
    if (budgetDb != null &&
        _budgetAmount.text.isEmpty &&
        _budgetTitle.text.isEmpty) {
      await _budgetStorageTwoService.deleteExpense(
        budgetDocumentId: budgetDb.documnetId,
      );
    }
  }

  // void saveIfTextIsNotEmpty() async {
  //   final budgetDb = _budgetItemTwo;
  //   final budTitle = _budgetTitle.text;
  //   final budAmount = _budgetAmount.text;
  //   final selectItem = selectedItem;
  //   if (budgetDb != null && budTitle.isNotEmpty && budAmount.isNotEmpty) {
  //     await _budgetStorageTwoService.updateBudgetTwo(
  //       budgetDocumentId: budgetDb.documnetId,
  //       title: budTitle,
  //       amount: budAmount,
  //       dropItem: selectItem,
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: createBudget(context),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(Icons.arrow_back),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: AppCustomTextField(
                          controller: _budgetTitle,
                          hintText: 'Title',
                          textInputType: TextInputType.text,
                          autoFocus: true,
                          obscureText: false,
                          autoCorrect: true,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: AppCustomTextField(
                          autoFocus: false,
                          obscureText: false,
                          autoCorrect: true,
                          controller: _budgetAmount,
                          hintText: 'Amount',
                          textInputType: TextInputType.number,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: DropdownButton(
                            isExpanded: true,
                            value: selectedItem,
                            items: dropList
                                .map(
                                  (dList) => DropdownMenuItem(
                                    value: dList,
                                    child: Text(dList),
                                  ),
                                )
                                .toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedItem = newValue!;
                              });
                            }),
                      ),
                      const SizedBox(height: 30),
                      AppButton(
                        onTap: () {
                          if (_budgetItemTwo?.documnetId == null) {
                            createBudget2();
                          } else {
                            updateBudget();
                          }
                          Navigator.of(context).popAndPushNamed(homeRoute);
                        },
                        text: 'Save Budget',
                      ),
                    ],
                  ),
                ),
              );
            default:
              return const CircularProgressIndicator();
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _deleteBudget();
    // saveIfTextIsNotEmpty();
    _budgetAmount.dispose();
    _budgetTitle.dispose();
    super.dispose();
  }
}
