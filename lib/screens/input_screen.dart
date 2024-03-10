// ignore_for_file: avoid_print

import 'package:ai_health/screens/recommendation_screen.dart';
import 'package:ai_health/utils/prediction_type.dart';
import 'package:ai_health/viewModels/prediction_view_model.dart';
import 'package:ai_health/widgets/input_field.dart';
import 'package:flutter/material.dart';

class InputScreen extends StatefulWidget {
  const InputScreen({super.key, required this.predictionType});

  final PredictionType predictionType;
  static final _formKey = GlobalKey<FormState>();

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  final predictionViewModel = PredictionViewModel();
  bool isBusy = false;
  bool isHigh = false;
  int responseData = 0;

  String glucoseValue = "0";
  String bloodPressureValue = "0";
  String skinThicknessValue = "0";
  String insulinValue = "0";
  String bmiValue = "0";
  String diabetesPedigreeFunctionValue = "0";
  String ageValue = "0";
  String sexValue = "0";
  String chestPainValue = "0";

  void onSubmit() async {
    if (!InputScreen._formKey.currentState!.validate()) {
      return;
    }

    InputScreen._formKey.currentState!.save();

    print(
      "$glucoseValue | $bloodPressureValue | $skinThicknessValue | $insulinValue | $bmiValue | $diabetesPedigreeFunctionValue | $ageValue | $sexValue | $chestPainValue",
    );

    setState(() {
      isBusy = true;
      responseData = 0;
    });

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (cntxt) => processingDialog(),
    );

    // API call
    await predictionViewModel
        .makeApiRequest(
      glucoseValue,
      bloodPressureValue,
      skinThicknessValue,
      insulinValue,
      bmiValue,
      diabetesPedigreeFunctionValue,
      ageValue,
      sexValue,
      chestPainValue,
      widget.predictionType,
    )
        .then((value) {
      bool shouldShowRecommendation = false;
      switch (widget.predictionType) {
        case PredictionType.bloodPressure:
          if (value > 120) {
            shouldShowRecommendation = true;
          }
          break;
        case PredictionType.diabetes:
          if (value == 1) {
            shouldShowRecommendation = true;
          }
          break;
        case PredictionType.cholesterol:
          if (value > 160) {
            shouldShowRecommendation = true;
          }
          break;
      }

      setState(() {
        isBusy = false;
        isHigh = shouldShowRecommendation;
        responseData = value;
      });
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isCholesterolPrediction =
        widget.predictionType == PredictionType.cholesterol;

    String screenTitle = "";
    switch (widget.predictionType) {
      case PredictionType.cholesterol:
        screenTitle = "Cholesterol Prediction";
        break;
      case PredictionType.diabetes:
        screenTitle = "Diabetes Prediction";
        break;
      case PredictionType.bloodPressure:
        screenTitle = "Blood Pressure Prediction";
        break;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(screenTitle),
      ),
      body: Form(
        key: InputScreen._formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              renderInputFields(isCholesterolPrediction),
              const SizedBox(height: 50),
              CircleAvatar(
                maxRadius: 40,
                child: Text(
                  widget.predictionType == PredictionType.diabetes
                      ? responseData == 1
                          ? "Yes"
                          : "NO"
                      : responseData.toString(),
                ),
              ),
              const SizedBox(height: 5),
              const Text("RESULT"),
              isHigh
                  ? TextButton(
                      onPressed: () {
                        bool isHigh = false;

                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (cntxt) => RecommendationScreen(
                              responseData: isHigh,
                              typeOfPrediction: widget.predictionType,
                            ),
                          ),
                        );
                      },
                      child: const Text("Recommendation"),
                    )
                  : const SizedBox()
            ],
          ),
        ),
      ),
    );
  }

  Widget renderInputFields(bool isCholesterolPrediction) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (!isCholesterolPrediction)
          InputField(
            title: "Glucose",
            onSave: (value) => glucoseValue = value,
          ),
        if (isCholesterolPrediction ||
            widget.predictionType == PredictionType.diabetes)
          InputField(
            title: "Blood Pressure",
            onSave: (value) => bloodPressureValue = value,
          ),
        if (!isCholesterolPrediction)
          InputField(
            title: "Skin Thickness",
            onSave: (value) => skinThicknessValue = value,
          ),
        if (!isCholesterolPrediction)
          InputField(
            title: "Insulin",
            onSave: (value) => insulinValue = value,
          ),
        if (!isCholesterolPrediction)
          InputField(
            title: "BMI",
            onSave: (value) => bmiValue = value,
          ),
        if (!isCholesterolPrediction)
          InputField(
            title: "Diabetes Pedigree Function",
            onSave: (value) => diabetesPedigreeFunctionValue = value,
          ),
        InputField(
          title: "Age",
          onSave: (value) => ageValue = value,
        ),
        if (isCholesterolPrediction)
          InputField(
            title: "Sex (Male: 1 | Female: 0)",
            onSave: (value) => sexValue = value,
          ),
        if (isCholesterolPrediction)
          InputField(
            title: "Chest Pain Level",
            onSave: (value) => chestPainValue = value,
          ),
        ElevatedButton(
          onPressed: onSubmit,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(
                vertical: 10, horizontal: 10), // Button padding
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: const Text(
            'PREDICT',
          ),
        ),
      ],
    );
  }

  AlertDialog processingDialog() {
    return const AlertDialog(
      title: Text("Predicting", textAlign: TextAlign.center),
      content: SizedBox(
        height: 100,
        width: 100,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
