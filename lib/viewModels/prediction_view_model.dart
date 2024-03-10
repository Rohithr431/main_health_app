// ignore_for_file: avoid_print

import 'package:ai_health/utils/prediction_type.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

class PredictionViewModel {
  PredictionViewModel._();

  static final _instance = PredictionViewModel._();

  factory PredictionViewModel() {
    return _instance;
  }

  String generateRequestBody(
    String glucoseValue,
    String bloodPressureValue,
    String skinThicknessValue,
    String insulinValue,
    String bmiValue,
    String diabetesPedigreeFunctionValue,
    String ageValue,
    String sexValue,
    String chestPainValue,
    PredictionType predictionType,
  ) {
    Map<String, dynamic> bodyData = {};

    if (predictionType == PredictionType.cholesterol) {
      bodyData = {
        "age": int.parse(ageValue),
        "sex": int.parse(sexValue),
        "cp": int.parse(chestPainValue),
        "trestbps": int.parse(bloodPressureValue),
      };
    }

    if (predictionType == PredictionType.diabetes) {
      bodyData = {
        "Glucose": int.parse(glucoseValue),
        "BloodPressure": int.parse(bloodPressureValue),
        "SkinThickness": int.parse(skinThicknessValue),
        "Insulin": int.parse(insulinValue),
        "BMI": double.parse(bmiValue),
        "DiabetesPedigreeFunction": double.parse(diabetesPedigreeFunctionValue),
        "Age": int.parse(ageValue),
      };
    }

    if (predictionType == PredictionType.bloodPressure) {
      bodyData = {
        "Glucose": int.parse(glucoseValue),
        "SkinThickness": int.parse(skinThicknessValue),
        "Insulin": int.parse(insulinValue),
        "BMI": double.parse(bmiValue),
        "DiabetesPedigreeFunction": double.parse(diabetesPedigreeFunctionValue),
        "Age": int.parse(ageValue),
      };
    }

    String jsonBodyData = json.encode(bodyData);
    print("JSON body: $jsonBodyData");

    return jsonBodyData;
  }

  Future<int> makeApiRequest(
    String glucoseValue,
    String bloodPressureValue,
    String skinThicknessValue,
    String insulinValue,
    String bmiValue,
    String diabetesPedigreeFunctionValue,
    String ageValue,
    String sexValue,
    String chestPainValue,
    PredictionType predictionType,
  ) async {
    var headers = {'Content-Type': 'application/json'};

    var body = generateRequestBody(
      glucoseValue,
      bloodPressureValue,
      skinThicknessValue,
      insulinValue,
      bmiValue,
      diabetesPedigreeFunctionValue,
      ageValue,
      sexValue,
      chestPainValue,
      predictionType,
    );

    //  json
    //     .encode({"age": 53, "sex": 1, "cp": 1, "trestbps": 145})

    final baseUrl = "https://server-mwct.onrender.com";
    String path = "";

    switch (predictionType) {
      case PredictionType.bloodPressure:
        path = "/bp";
        break;
      case PredictionType.diabetes:
        path = "/diabetes";
        break;
      case PredictionType.cholesterol:
        path = "/cholestrol";
        break;
    }

    final apiUrl = baseUrl + path;
    print(apiUrl);

    var dio = Dio();

    try {
      var response = await dio.request(
        apiUrl,
        options: Options(
          method: 'GET',
          headers: headers,
          sendTimeout: const Duration(seconds: 5),
          receiveTimeout: const Duration(seconds: 5),
        ),
        data: body,
      );

      if (response.statusCode == 200) {
        var responseData = response.data;
        print(responseData);
        var data = json.decode(responseData["prediction_label"]);
        print("Response Data: ${data["0"]}");

        var separatedData = data["0"].toString().split(".");
        return int.parse(separatedData[0]);
      } else {
        print(response.statusMessage);
        return 0;
      }
    } catch (e) {
      print("API CATCH $e");
      return -1;
    }
  }
}
