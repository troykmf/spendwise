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
    _saveExpenseIfNotEmpty();
    _deleteTransactionDetailIfTextIsEmpty();
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
      body: FutureBuilder(
        future: createOrGetExistingCategory(context),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              _setupTextControllerListener();
              return SizedBox(
                height: double.maxFinite,
                width: double.maxFinite,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 12.0),
                        AppCustomTextField(
                          autoFocus: true,
                          obscureText: false,
                          autoCorrect: true,
                          controller: _title,
                          hintText: 'Title',
                          textInputType: TextInputType.text,
                        ),
                        const SizedBox(height: 12.0),
                        AppCustomTextField(
                          autoFocus: false,
                          obscureText: false,
                          autoCorrect: false,
                          controller: _amount,
                          hintText: 'Enter Amount',
                          textInputType: TextInputType.number,
                        ),
                        const SizedBox(height: 12.0),
                        AppCustomTextField(
                          autoFocus: false,
                          obscureText: false,
                          autoCorrect: true,
                          controller: _transactonType,
                          hintText: 'Enter a Tranaction Type',
                          textInputType: TextInputType.text,
                        ),
                        const SizedBox(height: 12.0),
                        AppCustomTextField(
                          autoFocus: false,
                          obscureText: false,
                          autoCorrect: true,
                          controller: _when,
                          hintText: 'Enter your desired date',
                          textInputType: TextInputType.text,
                        ),
                        const SizedBox(height: 12.0),
                        AppCustomTextField(
                          autoFocus: false,
                          obscureText: false,
                          autoCorrect: true,
                          controller: _note,
                          hintText: 'Write a note',
                          textInputType: TextInputType.text,
                        ),
                        const SizedBox(height: 12.0),
                      ],
                    ),
                  ),
                ),
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
