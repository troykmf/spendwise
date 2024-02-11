import 'package:flutter/material.dart';

class OnboardingOne extends StatelessWidget {
  const OnboardingOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Container(
      width: width,
      height: height,
      decoration: const BoxDecoration(
        color: Colors.white70,
      ),
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Welcome to Spendwise! \nTake control of your finances by tracking your expenses effortlessly',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
