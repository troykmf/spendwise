import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:spendwise/src/bar_graph/individual_bar.dart';

class MonthlyBarGraph extends StatefulWidget {
  final List<double> monthlySummary;
  final int startOfMonth;
  const MonthlyBarGraph({
    super.key,
    required this.monthlySummary,
    required this.startOfMonth,
  });

  @override
  State<MonthlyBarGraph> createState() => _MonthlyBarGraphState();
}

class _MonthlyBarGraphState extends State<MonthlyBarGraph> {
  List<IndividualBar> monthlyBarData = [];

  void initializeMonthlyBarData() {
    monthlyBarData = List.generate(
      widget.monthlySummary.length,
      (index) => IndividualBar(
        x: index,
        y: widget.monthlySummary[index],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        minY: 0,
        maxY: 100,
      ),
    );
  }
}
