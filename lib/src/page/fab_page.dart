import 'package:flutter/material.dart';
import 'package:spendwise/services/cloud_database/cloud_storage.dart';
import 'package:spendwise/services/cloud_database/firebase_cloud_storage.dart';
import 'package:spendwise/core/constants/constant_widgets/apptextfield.dart';
import 'package:spendwise/services/auth/auth_service.dart';
import 'package:spendwise/core/utilities/generics/get_arguments.dart';

class FabPage extends StatefulWidget {
  const FabPage({super.key});

  @override
  State<FabPage> createState() => _FabPageState();
}

class _FabPageState extends State<FabPage> {
  CloudDatabase? _database;

  late final FirebaseCloudStorage _cloudStorageService;

  late final TextEditingController _title;
  late final TextEditingController _amount;
  late final TextEditingController _transactonType;
  late final TextEditingController _tag;
  late final TextEditingController _when;
  late final TextEditingController _note;

  @override
  void initState() {
    _cloudStorageService = FirebaseCloudStorage();
    _title = TextEditingController();
    _amount = TextEditingController();
    _transactonType = TextEditingController();
    _tag = TextEditingController();
    _when = TextEditingController();
    _note = TextEditingController();
    super.initState();
  }

  void _textControllerListener() async {
    final database = _database;

    if (database == null) {
      return;
    }
    final title = _title.text;
    final amount = _amount.text;
    final transactionType = _transactonType.text;
    final tag = _tag.text;
    final when = _when.text;
    final note = _note.text;

    await _cloudStorageService.updateExpense(
      documentId: database.documentId,
      title: title,
      amount: amount,
      transactionType: transactionType,
      tag: tag,
      when: when,
      note: note,
    );
  }

  void _saveExpenseIfNotEmpty() async {
    final database = _database;
    final title = _title.text;
    final amount = _amount.text;
    final transactionType = _transactonType.text;
    final tag = _tag.text;
    final when = _when.text;
    final note = _note.text;

    if (database != null &&
        title.isNotEmpty &&
        amount.isNotEmpty &&
        transactionType.isNotEmpty &&
        tag.isNotEmpty &&
        when.isNotEmpty &&
        note.isNotEmpty) {
      await _cloudStorageService.updateExpense(
        documentId: database.documentId,
        title: title,
        amount: amount,
        transactionType: transactionType,
        tag: tag,
        when: when,
        note: note,
      );
    }
  }

  void _setupTextControllerListener() {
    _title.removeListener(_textControllerListener);
    _title.addListener(_textControllerListener);

    _amount.removeListener(_textControllerListener);
    _amount.addListener(_textControllerListener);

    _transactonType.removeListener(_textControllerListener);
    _transactonType.addListener(_textControllerListener);

    _tag.removeListener(_textControllerListener);
    _tag.addListener(_textControllerListener);

    _when.removeListener(_textControllerListener);
    _when.addListener(_textControllerListener);

    _note.removeListener(_textControllerListener);
    _note.addListener(_textControllerListener);
  }

  Future<CloudDatabase> createOrGetExistingCategory(
      BuildContext context) async {
    final widgetTransactionDetail = context.getArgument<CloudDatabase>();

    if (widgetTransactionDetail != null) {
      _database = widgetTransactionDetail;
      _title.text = widgetTransactionDetail.title;
      _amount.text = widgetTransactionDetail.amount;
      _transactonType.text = widgetTransactionDetail.transactionType;
      _tag.text = widgetTransactionDetail.tag;
      _when.text = widgetTransactionDetail.when;
      _note.text = widgetTransactionDetail.note;

      return widgetTransactionDetail;
    }

    final existingTransactionDetail = _database;
    if (existingTransactionDetail != null) {
      return existingTransactionDetail;
    }

    final currentUser = AuthService.firebase().currentUser!;

    final userId = currentUser.id;
    final newTransactionDetail = await _cloudStorageService.createNewExpense(
      ownerUserId: userId,
    );
    _database = newTransactionDetail;

    return newTransactionDetail;
  }

  void _deleteTransactionDetailIfTextIsEmpty() {
    final transactionDetailDatabase = _database;
    if (_title.text.isEmpty &&
        _amount.text.isEmpty &&
        _transactonType.text.isEmpty &&
        _tag.text.isEmpty &&
        _when.text.isEmpty &&
        _note.text.isEmpty &&
        transactionDetailDatabase != null) {
      _cloudStorageService.deleteExpense(
        documentId: transactionDetailDatabase.documentId,
      );
    }
  }

  @override
  void dispose() {
    _title.dispose();
    _amount.dispose();
    _transactonType.dispose();
    _tag.dispose();
    _when.dispose();
    _note.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaction Details'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () {},
      //   label: const Row(
      //     children: [
      //       Icon(
      //         Icons.create_outlined,
      //       ),
      //       Text('Edit'),
      //     ],
      //   ),
      // ),
      body: FutureBuilder(
        future: createOrGetExistingCategory(context),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              _setupTextControllerListener();
              return ListView(
                children: [
                  TextField(
                    keyboardType: TextInputType.text,
                    controller: _title,
                    decoration: InputDecoration(
                      hintStyle: const TextStyle(
                        color: Colors.black,
                      ),
                      contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        // borderSide: BorderSide(color: Colors.grey.shade50),
                      ),
                      alignLabelWithHint: false,
                      hintText: 'Title',
                    ),
                  ),
                  AppTextField(
                    controller: _amount,
                    hintText: 'Enter Amount',
                    labelText: 'Amount',
                    textInputType: TextInputType.number,
                    autoFocus: false,
                    obscureText: false,
                    autoCorrect: true,
                  ),
                  AppTextField(
                    controller: _transactonType,
                    hintText: 'Enter a Tranaction Type',
                    labelText: 'Transaction Type',
                    textInputType: TextInputType.text,
                    autoFocus: false,
                    obscureText: false,
                    autoCorrect: true,
                  ),
                  AppTextField(
                    controller: _tag,
                    hintText: 'Tag',
                    labelText: 'Tag',
                    textInputType: TextInputType.text,
                    autoFocus: false,
                    obscureText: false,
                    autoCorrect: true,
                  ),
                  AppTextField(
                    controller: _when,
                    hintText: 'Enter your desired date',
                    labelText: 'When',
                    textInputType: TextInputType.text,
                    autoFocus: false,
                    obscureText: false,
                    autoCorrect: true,
                  ),
                  AppTextField(
                    controller: _note,
                    hintText: 'Note',
                    labelText: 'Note',
                    textInputType: TextInputType.text,
                    autoFocus: false,
                    obscureText: false,
                    autoCorrect: true,
                  ),
                ],
              );
            default:
              const CircularProgressIndicator();
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
