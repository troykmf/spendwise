import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:spendwise/src/bar_graph/bar_data.dart';

class MyBarGraph extends StatelessWidget {
  const MyBarGraph({
    super.key,
    this.maxY,
    required this.sunAmount,
    required this.monAmount,
    required this.tueAmount,
    required this.wedAmount,
    required this.thuAmount,
    required this.friAmount,
    required this.satAmount,
  });

  final double? maxY;
  final double sunAmount;
  final double monAmount;
  final double tueAmount;
  final double wedAmount;
  final double thuAmount;
  final double friAmount;
  final double satAmount;
  @override
  Widget build(BuildContext context) {
    BarData myBarData = BarData(
      sunAmount: sunAmount,
      monAmount: monAmount,
      tueAmount: tueAmount,
      wedAmount: wedAmount,
      thuAmount: thuAmount,
      friAmount: friAmount,
      satAmount: satAmount,
    );

    myBarData.initializeBarData();

    return BarChart(
      BarChartData(
        barGroups: myBarData.barData
            .map(
              (data) => BarChartGroupData(
                x: data.x,
                barRods: [
                  BarChartRodData(
                    toY: data.y,
                    color: Colors.grey[800],
                    width: 25,
                    backDrawRodData: BackgroundBarChartRodData(
                      show: true,
                      toY: maxY,
                      color: Colors.grey[200],
                    ),
                  )
                ],
              ),
            )
            .toList(),
      ),
    );
  }

  Widget getBottomTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.grey,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );

    Widget text;

    switch (value.toInt()) {
      case 1:
        text = const Text(
          'S',
          style: style,
        );
        break;

      case 2:
        text = const Text(
          'M',
          style: style,
        );
        break;

      case 3:
        text = const Text(
          'T',
          style: style,
        );
        break;

      case 4:
        text = const Text(
          'W',
          style: style,
        );
        break;

      case 5:
        text = const Text(
          'T',
          style: style,
        );
        break;

      case 6:
        text = const Text(
          'F',
          style: style,
        );
        break;

      case 7:
        text = const Text(
          'S',
          style: style,
        );
        break;

      default:
        text = const Text(
          '',
          style: style,
        );
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }
}
