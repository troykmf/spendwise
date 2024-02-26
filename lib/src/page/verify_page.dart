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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Please check your mail and verify your account',
            style: TextStyle(fontSize: 16),
          ),
          Center(
            child: TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(loginRoute, (route) => false);
              },
              child: const Text('Go to login page',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
