import 'package:flutter/material.dart';
import 'package:spendwise/core/constants/route.dart';

class VerifyPage extends StatelessWidget {
  const VerifyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('verify'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          TextButton(
            onPressed: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(loginRoute, (route) => false);
            },
            child: const Text('Go to log in'),
          ),
        ],
      ),
    );
  }
}
