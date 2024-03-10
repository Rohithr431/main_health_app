import 'package:ai_health/screens/input_screen.dart';
import 'package:ai_health/utils/prediction_type.dart';
import 'package:ai_health/widgets/choice_button.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI Health',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  void navigate(BuildContext context, PredictionType predictionType) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (cntxt) => InputScreen(predictionType: predictionType),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Health AI',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w400),
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Icon(
            Icons.favorite_border,
            color: Colors.red,
            size: 140,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ChoiceButton(
                  onClick: () {
                    navigate(context, PredictionType.cholesterol);
                  },
                  title: "Cholesterol Prediction",
                ),
                ChoiceButton(
                  onClick: () {
                    navigate(context, PredictionType.diabetes);
                  },
                  title: "Diabetes Prediction",
                ),
                ChoiceButton(
                  onClick: () {
                    navigate(context, PredictionType.bloodPressure);
                  },
                  title: "Blood Pressure Prediction",
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
