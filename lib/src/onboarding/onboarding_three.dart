import 'package:flutter/material.dart';

class OnboardingThree extends StatelessWidget {
  const OnboardingThree({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Container(
      width: width,
      height: height,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Track, categorize, and manage your expenses with ease. \nSpendwise is here to simplify your financial life.',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
