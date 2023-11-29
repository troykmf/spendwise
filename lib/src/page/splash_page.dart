import 'dart:async';
import 'package:spendwise/core/constants/colors.dart';
import 'package:spendwise/core/constants/route.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Timer(
      const Duration(seconds: 4),
      () => Navigator.of(context).pushNamedAndRemoveUntil(
        signupRoute,
        (route) => false,
      ),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomRight,
            colors: [AppColor.whiteColor, AppColor.blueColor],
          ),
        ),
        child: Image.network(
          'https://img.freepik.com/free-vector/pay-balance-owed-abstract-concept-illustration-making-credit-payment-pay-owed-money-bank-irs-balance-due-debt-consolidation-management-taxpayer-bill_335657-1236.jpg?size=626&ext=jpg&ga=GA1.1.236206376.1670018423&semt=ais',
        ),
      ),
    );
  }
}
