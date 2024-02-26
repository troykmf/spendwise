// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:spendwise/core/constants/date_time_helper.dart';
// import 'package:spendwise/services/models/budgets/budget_data.dart';
// import 'package:spendwise/src/bar_graph/monthly/monthly_bar_graph.dart';

// class MonthlySummary extends StatefulWidget {
//   const MonthlySummary({super.key});

//   @override
//   State<MonthlySummary> createState() => _MonthlySummaryState();
// }

// class _MonthlySummaryState extends State<MonthlySummary> {
//   Future<Map<int, double>>? _monthlyTotalFuture;

//   @override
//   void initState() {
//     Provider.of<BudgetData>(context, listen: false).getAllBudgetItemList();
//     refreshGraphData();
//     super.initState();
//   }

//   void refreshGraphData() {
//     _monthlyTotalFuture = Provider.of<BudgetData>(context, listen: false)
//         .calculateMonthlyTotals();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<BudgetData>(
//       builder: (context, value, child) {
//         int startMonth = value.getStartMonth();
//         int startYear = value.getStartYear();
//         int currentMonth = DateTime.now().month;
//         int currentYear = DateTime.now().year;

//         // calculate number of months since the first month
//         int monthCount = calculateMonthCount(
//           startYear,
//           startMonth,
//           currentYear,
//           currentMonth,
//         );

//         return Scaffold(
//             body: FutureBuilder(
//           future: _monthlyTotalFuture,
//           builder: (context, snapshot) {

            
//             // List<double> monthlySummary = List.generate(monthCount, (index) => monthlyTotals)
//             return MonthlyBarGraph(
//               monthlySummary: monthlySummary,
//               startOfMonth: startMonth,
//             );
//           },
//         ));
//       },
//     );
//   }
// }
