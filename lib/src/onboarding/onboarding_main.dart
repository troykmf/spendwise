import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:spendwise/core/constants/route.dart';
import 'package:spendwise/src/onboarding/onboarding_one.dart';
import 'package:spendwise/src/onboarding/onboarding_three.dart';
import 'package:spendwise/src/onboarding/onboarding_two.dart';

class OnboardingMain extends StatefulWidget {
  const OnboardingMain({Key? key}) : super(key: key);

  @override
  State<OnboardingMain> createState() => _OnboardingMainState();
}

class _OnboardingMainState extends State<OnboardingMain> {
  bool onLastPage = false;

  PageController _controller = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                onLastPage = (index == 2);
              });
            },
            children: [
              OnboardingOne(),
              OnboardingTwo(),
              OnboardingThree(),
            ],
          ),
          //  dot indicator
          Container(
            alignment: const Alignment(0, 0.75),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // skip
                GestureDetector(
                  onTap: () {
                    _controller.previousPage(
                      duration: const Duration(microseconds: 500),
                      curve: Curves.easeIn,
                    );
                  },
                  child: const Text('Prev'),
                ),

                SmoothPageIndicator(controller: _controller, count: 3),

                // next
                onLastPage
                    ? GestureDetector(
                        onTap: () {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            homeMainRoute,
                            (route) => false,
                          );
                        },
                        child: const Text('Done'),
                      )
                    : GestureDetector(
                        onTap: () {
                          _controller.nextPage(
                            duration: const Duration(microseconds: 500),
                            curve: Curves.easeIn,
                          );
                        },
                        child: const Text('Next'),
                      ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
