import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ChartExample extends StatelessWidget{
  const ChartExample({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contoh Chart"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: LineChart(
          LineChartData(
            lineBarsData: [
              LineChartBarData(
                spots: const [
                  // ambil dari rest api
                ],
                isCurved: false,
                barWidth: 2,
                color: Colors.yellow,

              ),
            ],
          ),
        ),
      ),
    );
  }
}