// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class InputPage extends StatelessWidget {
  const InputPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Diabetes Prediction'),
      ),
      body: const InputForm(),
    );
  }
}

class InputForm extends StatefulWidget {
  const InputForm({super.key});

  @override
  _InputFormState createState() => _InputFormState();
}

class _InputFormState extends State<InputForm> {
  TextEditingController glucoseController = TextEditingController();
  TextEditingController bloodPressureController = TextEditingController();
  TextEditingController skinThicknessController = TextEditingController();
  TextEditingController insulinController = TextEditingController();
  TextEditingController bmiController = TextEditingController();
  TextEditingController diabetesPedigreeFunctionController =
      TextEditingController();
  TextEditingController ageController = TextEditingController();

  String outcome = '';

  Future<void> submitForm() async {
    // Prepare data to send to API
    Map<String, dynamic> requestData = {
      "Glucose": int.tryParse(glucoseController.text) ?? 0,
      "BloodPressure": int.tryParse(bloodPressureController.text) ?? 0,
      "SkinThickness": int.tryParse(skinThicknessController.text) ?? 0,
      "Insulin": int.tryParse(insulinController.text) ?? 0,
      "BMI": double.tryParse(bmiController.text) ?? 0,
      "DiabetesPedigreeFunction":
          double.tryParse(diabetesPedigreeFunctionController.text) ?? 0,
      "Age": int.tryParse(ageController.text) ?? 0,
    };

    // Convert data to JSON
    String jsonData = json.encode(requestData);
    print(jsonData);
    // Make POST request to API
    var response = await http.post(
      Uri.parse('https://server-mwct.onrender.com/diabetes'),
      headers: {"Content-Type": "application/json"},
      body: jsonData,
    );
    print(response);

    // Handle response
    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = json.decode(response.body);
      List<dynamic> predictionList = responseData['prediction_label'];
      print(predictionList);
      // Display prediction in the bottom field
      setState(() {
        outcome = 'Prediction: $predictionList';
      });
    } else {
      setState(() {
        outcome = 'Error: ${response.reasonPhrase}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: glucoseController,
              decoration: const InputDecoration(labelText: 'Glucose'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: bloodPressureController,
              decoration: const InputDecoration(labelText: 'Blood Pressure'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: skinThicknessController,
              decoration: const InputDecoration(labelText: 'Skin Thickness'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: insulinController,
              decoration: const InputDecoration(labelText: 'Insulin'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: bmiController,
              decoration: const InputDecoration(labelText: 'BMI'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: diabetesPedigreeFunctionController,
              decoration: const InputDecoration(
                  labelText: 'Diabetes Pedigree Function'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: ageController,
              decoration: const InputDecoration(labelText: 'Age'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(
                height: 20), // Add spacing between text fields and button
            ElevatedButton(
              onPressed:
                  submitForm, // Call submitForm method when button is pressed
              child: const Text('Submit'),
            ),
            const SizedBox(height: 20),
            Text(outcome), // Display outcome
          ],
        ),
      ),
    );
  }
}
