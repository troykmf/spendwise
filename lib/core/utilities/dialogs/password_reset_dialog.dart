import 'package:flutter/cupertino.dart';
import 'package:spendwise/core/utilities/dialogs/generic_dialog.dart';

Future<void> passwordResetSentDialog(BuildContext context) {
  return showGenericDialog<void>(
    context: context,
    title: 'Password Reset',
    content: 'Please check your mail and reset your password',
    optionBuilder: () => {
      'ok': null,
    },
  );
}
