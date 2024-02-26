import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:spendwise/core/constants/route.dart';
import 'package:spendwise/new_youtube/new_stuff/new_tab_bar_view.dart';
import 'package:spendwise/removed_code/category_list.dart';
import 'package:spendwise/removed_code/tab_bar_view.dart';

class TransanctionScreen extends StatefulWidget {
  TransanctionScreen({super.key});

  @override
  State<TransanctionScreen> createState() => _TransanctionScreenState();
}

class _TransanctionScreenState extends State<TransanctionScreen> {
  var category = 'All';

  var monthyear = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Expansive',
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushNamed(homeRoute);
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TimeLineMonth(
              onchnaged: (String? value) {
                if (value != null) {
                  setState(() {
                    monthyear = value;
                  });
                }
              },
            ),
            const SizedBox(
              height: 10,
            ),
            CatgoryList(
              onchnaged: (String? value) {
                if (value != null) {
                  setState(() {
                    category = value;
                  });
                }

              },
            ),
            // NewTabBarView(),
            TypeTabBar(category: category, monthyear: monthyear,),

          ],
        ),
      ),
    );
  }
}

class TimeLineMonth extends StatefulWidget {
  const TimeLineMonth({super.key, required this.onchnaged});
  final ValueChanged<String?> onchnaged;

  @override
  State<TimeLineMonth> createState() => _TimeLineMonthState();
}

class _TimeLineMonthState extends State<TimeLineMonth> {
  String currentMonth = '';
  List<String> months = [];
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    DateTime now = DateTime.now();
    for (int i = -18; i <= 0; i++) {
      months.add(
          DateFormat('MMM y').format(DateTime(now.year, now.month + i, 1)));
    }
    currentMonth = DateFormat('MMM y').format(now);

    Future.delayed(const Duration(seconds: 1), () {
      scrollToSelectedMonth();
    });
  }

  scrollToSelectedMonth() {
    final selectedMonth = months.indexOf(currentMonth);
    if (selectedMonth != -1) {
      final scrollOffset = (selectedMonth * 100.0) - 170;
      scrollController.animateTo(
        scrollOffset,
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      child: ListView.builder(
        controller: scrollController,
        itemCount: months.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                currentMonth = months[index];
                widget.onchnaged(months[index]);
              });
              scrollToSelectedMonth();
            },
            child: Container(
              width: 80,
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: currentMonth == months[index]
                    ? Colors.blue
                    : Colors.purple.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                  child: Text(
                months[index],
                style: TextStyle(
                  color: currentMonth == months[index]
                      ? Colors.white
                      : Colors.purple,
                ),
              )),
            ),
          );
        },
      ),
    );
  }
}
