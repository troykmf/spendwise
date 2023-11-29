import 'package:flutter/material.dart';
import 'package:spendwise/core/constants/route.dart';
import 'package:spendwise/services/auth/auth_service.dart';
import 'package:spendwise/core/utilities/dialogs/generic_dialog.dart';

Future<void> logoutDialog(
    BuildContext context, String text, Function() onPressed) {
  return showGenericDialog(
      context: context,
      title: 'Log out',
      content: 'Are you sure you want to logout?',
      optionBuilder: () => {
            'Logout': () async {
              await AuthService.firebase().logOut();
              Navigator.of(context).pushNamedAndRemoveUntil(
                loginRoute,
                (route) => false,
              );
            },
            'cancel': null,
          });
}
