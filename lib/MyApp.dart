import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'dart:math';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  double _loanAmount = 10000; // Initial loan amount
  double _years = 1.5; // Initial loan amount
  double _rate = 2; // Initial loan amount

  @override
  Widget build(BuildContext context) {
    int loanAmountInt = _loanAmount.toInt(); // Convert double to integer
    int yearsInt = _years.toInt(); // Convert double to integer
    int rateInt = _rate.toInt(); // Convert double to integer

    // Data for the pie chart
    Map<String, double> dataMap = {
      'Amount': _loanAmount,
      'Rate': _rate,
      'Time': _years,
    };

    // Calculation
    int result = (_loanAmount *
        _rate *
        pow((1 + _rate / 100), _years) /
        (pow((1 + _rate / 100), _years) - 1))
        .toInt();

    // Monthly EMI Calculation
    int monthlyEMI = (_loanAmount / (_years * 12)).toInt();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Center(
          child: Text(
            "EMI Calculator",
            style: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Loan Amount",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                ),
                Slider(
                  onChanged: (value) {
                    setState(() {
                      _loanAmount = value; // Update the loan amount state
                    });
                  },
                  min: 25000,
                  max: 1000000,
                  value: _loanAmount,
                ),
                Text(
                  "RS.$loanAmountInt", // Display the integer part of the selected loan amount
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                ),
              ],
            ),
            const SizedBox(height: 25.0),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Tenure(years)",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                ),
                Slider(
                  onChanged: (value) {
                    setState(() {
                      _years = value; // Update the loan amount state
                    });
                  },
                  min: 1,
                  max: 10,
                  value: _years,
                ),
                Text(
                  "$yearsInt", // Display the integer part of the selected loan amount
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                ),
              ],
            ),
            const SizedBox(height: 25.0),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Interest Rate (% P.A.)",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                ),
                Slider(
                  onChanged: (value) {
                    setState(() {
                      _rate = value; // Update the loan amount state
                    });
                  },
                  min: 7,
                  max: 14,
                  value: _rate,
                ),
                Text(
                  "$rateInt %", // Display the integer part of the selected loan amount
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                ),
              ],
            ),
            const SizedBox(height: 25.0),
            // Add Pie Chart here
            PieChart(
              dataMap: dataMap,
              animationDuration: const Duration(milliseconds: 800),
              chartLegendSpacing: 32.0,
              chartRadius: MediaQuery.of(context).size.width / 3.2,
              initialAngleInDegree: 0,
              chartType: ChartType.disc,
              ringStrokeWidth: 32,
              centerText: "Loan Details",
              legendOptions: const LegendOptions(
                showLegendsInRow: true,
                legendPosition: LegendPosition.bottom,
                showLegends: true,
                legendTextStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              chartValuesOptions: const ChartValuesOptions(
                showChartValueBackground: true,
                showChartValues: true,
                showChartValuesInPercentage: true,
                showChartValuesOutside: false,
              ),
            ),
            const SizedBox(height: 25.0),
            // Display Result
            Text(
              "Total EMI: $result",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            Text(
              "Monthly EMI: $monthlyEMI",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
