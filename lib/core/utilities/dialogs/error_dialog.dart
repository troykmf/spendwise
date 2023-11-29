import 'package:spendwise/core/utilities/dialogs/generic_dialog.dart';
import 'package:flutter/material.dart';

Future<void> showErrorDialog(
  BuildContext context,
  String text,
) {
  return showGenericDialog(
    context: context,
    title: 'Oops! An error occurred',
    content: text,
    optionBuilder: () => {
      'Ok': null,
    },
  );
}
