// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
//
// class TimeLineMonth extends StatefulWidget {
//   const TimeLineMonth({super.key, required this.onchanged});
//   final ValueChanged<String?> onchanged;
//
//   @override
//   State<TimeLineMonth> createState() => _TimeLineMonthState();
// }
//
// class _TimeLineMonthState extends State<TimeLineMonth> {
//   String currentMonth = '';
//   List<String> month = [];
//   final scrollController = ScrollController();
//
//   @override
//   void initState() {
//     DateTime now = DateTime.now();
//     for (int i = -18; i <= 0; i++) {
//       month
//           .add(DateFormat('MMM y').format(DateTime(now.year, now.year + 1, i)));
//     }
//     currentMonth = DateFormat('MMM y').format(now);
//
//     Future.delayed(const Duration(seconds: 2), () {
//       scrollToSelectedMonth();
//     });
//     super.initState();
//   }
//
//   scrollToSelectedMonth() {
//     final selectedMonth = month.indexOf(currentMonth);
//     if (selectedMonth != -1) {
//       final scrollOffset = (selectedMonth * 100.0) - 170;
//       scrollController.animateTo(
//         scrollOffset,
//         duration: const Duration(milliseconds: 500),
//         curve: Curves.easeIn,
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 40,
//       child: ListView.builder(
//         itemCount: 4,
//         scrollDirection: Axis.horizontal,
//         controller: scrollController,
//         itemBuilder: (context, index) {
//           return GestureDetector(
//             onTap: () {
//               setState(() {
//                 currentMonth = month[index];
//                 widget.onchanged(month[index]);
//               });
//             },
//             child: Container(
//               height: 80,
//               margin: const EdgeInsets.all(8),
//               decoration: BoxDecoration(
//                 color: currentMonth == month[index]
//                     ? Colors.blue
//                     : Colors.purple.withOpacity(0.1),
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: Center(
//                 child: Text(
//                   month[index],
//                   style: TextStyle(
//                     color: currentMonth == month[index]
//                         ? Colors.white
//                         : Colors.purple,
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
