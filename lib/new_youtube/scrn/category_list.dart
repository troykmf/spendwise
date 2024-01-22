import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:intl/intl.dart';
import 'package:spendwise/new_youtube/app_icons.dart';

class CatgoryList extends StatefulWidget {
  const CatgoryList({super.key, required this.onchnaged});
  final ValueChanged<String?> onchnaged;

  @override
  State<CatgoryList> createState() => _CatgoryListState();
}

class _CatgoryListState extends State<CatgoryList> {
  String currentCategory = '';
  List<Map<String, dynamic>> categoryList = [];

  final scrollController = ScrollController();
  var appIcons = Appicons();

  @override
  void initState() {
    super.initState();
    setState(() {
      categoryList = appIcons.homeExpensesCategories;
      categoryList.insert(0, addCart);
    });
  }

  // scrollToSelectedMonth() {
  //   final selectedMonth = months.indexOf(currentMonth);
  //   if (selectedMonth != -1) {
  //     final scrollOffset = (selectedMonth * 100.0) - 170;
  //     scrollController.animateTo(
  //       scrollOffset,
  //       duration: const Duration(milliseconds: 500),
  //       curve: Curves.ease,
  //     );
  //   }
  // }

  var addCart = {'name': 'All', 'icon': FontAwesomeIcons.cartPlus};

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: ListView.builder(
        controller: scrollController,
        itemCount: categoryList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          var data = appIcons.homeExpensesCategories[index];
          return GestureDetector(
            onTap: () {
              setState(() {
                currentCategory = data['name'];
                widget.onchnaged(data['name']);
              });
            },
            child: Container(
              // width: 100,
              margin: EdgeInsets.all(8),
              padding: EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                color: currentCategory == data['name']
                    ? Colors.blue.shade900
                    : Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                  child: Row(
                children: [
                  Icon(
                    data['icon'],
                    size: 10,
                    color: currentCategory == data['name']
                        ? Colors.white
                        : Colors.blue.shade900,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    data['name'],
                    style: TextStyle(
                      color: currentCategory == data['name']
                          ? Colors.white
                          : Colors.blue.shade900,
                    ),
                  ),
                ],
              )),
            ),
          );
        },
      ),
    );
  }
}
