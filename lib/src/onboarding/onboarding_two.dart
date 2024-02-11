import 'package:flutter/material.dart';

class OnboardingTwo extends StatelessWidget {
  const OnboardingTwo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Container(
      width: width,
      height: height,
      decoration: const BoxDecoration(
        color: Colors.blue,
      ),
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Get a clearer picture of your spending habits with Spendwise. \nLet's start your financial journey together!",
              style: TextStyle(
                color: Colors.white,
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
