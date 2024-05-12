
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart'; //flcharts charts plugin
import 'package:path_to_inputscreen/inputscreen.dart';




void main() => runApp(MainApp());

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LineChartPage(),
    );
  }
}

class LineChartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trends Graphs'),
        backgroundColor: Color.fromARGB(255, 232, 173, 247),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Handle the return button action (e.g., navigate back)
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 20),
            Text(
              'Cholesterol Line Chart',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.black,
              ),
            ),
            LineChartContainer(),
            // ... Other widgets if any
          ],
        ),
      ),
    );
  }
}




// Rest of the code remains unchanged...



class LineChartContainer extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      width: double.infinity,
      height: 400,
      padding: EdgeInsets.all(16),
      child: ListView(
        children: [
          AspectRatio(
  aspectRatio: 1.70,
  child: CustomLineChart(
    cholesterolSpots: cholesterolSpots,
    predictedCholesterol: 0, // Provide the predicted cholesterol value here
    onPredictionReceived: (newValue) { // Define the behavior when a new prediction is received
      // Update the cholesterol spots list with the new predicted value
      cholesterolSpots.add(FlSpot(cholesterolSpots.length.toDouble(), newValue));
    },
  ),
),
          SizedBox(height: 20),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      color: Colors.green,
                    ),
                    SizedBox(width: 8),
                    Text('Expected Cholesterol Range (Min)'),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      color: Colors.red,
                    ),
                    SizedBox(width: 8),
                    Text('Expected Cholesterol Range (Max)'),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      color: Colors.blue,
                    ),
                    SizedBox(width: 8),
                    Text('Predicted Cholesterol Values'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}



class CustomLineChart extends StatelessWidget {
  final List<FlSpot> cholesterolSpots;
  final double predictedCholesterol;
  final void Function(double) onPredictionReceived; // Add this line

  CustomLineChart({
    required this.cholesterolSpots,
    required this.predictedCholesterol,
    required this.onPredictionReceived, // Add callback function parameter
  });



  @override
  Widget build(BuildContext context) {
    // Update cholesterolSpots list with the predicted cholesterol value
    List<FlSpot> updatedCholesterolSpots = List.from(cholesterolSpots);
    updatedCholesterolSpots.add(FlSpot(cholesterolSpots.length.toDouble(), predictedCholesterol));

    return LineChart(
      LineChartData(
        lineBarsData: [
          LineChartBarData(
            spots: updatedCholesterolSpots,
            isCurved: true,
            color: Colors.blue, // Corrected to 'colors' which takes a list
            barWidth: 4,
            isStrokeCapRound: true,
            belowBarData: BarAreaData(
              show: true,
              color: Colors.blue.withOpacity(0.3), // Corrected to 'colors' which takes a list
            ),
          ),
        ],
        titlesData: FlTitlesData(
          topTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false)
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: true,
                reservedSize: 40),
          ),
          rightTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                const weekLabels = ['Week 1', 'Week 2', 'Week 3', 'Week 4', 'Week 5','Week 6'];
                // Ensure that the label is only shown for integer values (whole weeks)
                if (value % 1 == 0 && value >= 0 && value < weekLabels.length) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 10), // Adjust padding as needed
                    child: RotatedBox(
                      quarterTurns: 4,
                      child: Text(
                        weekLabels[value.toInt()],
                        style: TextStyle(
                          color: Color.fromARGB(255, 13, 13, 13),
                          fontWeight: FontWeight.normal,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  );
                }
                return Container();
              },
              reservedSize: 30, // Adjust the reserved size to fit the labels
            ),
          ),
        ),
        gridData: FlGridData(show: true),
        borderData: FlBorderData(
          show: true,
          border: Border.all(color: Colors.grey),
        ),
        minX: 0,
        maxX: 5,
        minY: 160,
        maxY: 220,
      ),
    );
  }
}
