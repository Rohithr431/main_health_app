import 'package:ai_health/utils/prediction_type.dart';
import 'package:flutter/material.dart';

class RecommendationScreen extends StatelessWidget {
  RecommendationScreen({
    super.key,
    required this.typeOfPrediction,
    required this.responseData,
  });

  final PredictionType typeOfPrediction;
  final bool responseData;

  String recommendationMessage = ''' ''';

  void generateRecommendation() {
    switch (typeOfPrediction) {
      case PredictionType.bloodPressure:
        recommendationMessage = '''
Adopt a healthy diet: Focus on consuming a balanced diet rich in fruits, vegetables, whole grains, lean proteins, and low-fat dairy products. Reduce your intake of sodium, saturated fats, and added sugars. For example, you can incorporate foods like spinach, bananas, salmon, and yogurt into your meals.
Reduce sodium intake: Limit your consumption of processed and packaged foods, as they tend to be high in sodium. Instead, opt for fresh, whole foods and use herbs and spices to flavor your meals. For instance, you can replace table salt with herbs like basil or spices like turmeric.
Exercise regularly: Engage in moderate-intensity aerobic exercises such as brisk walking, cycling, or swimming for at least 150 minutes per week. Additionally, incorporate strength training exercises into your routine twice a week. For example, you can go for a 30-minute jog or join a yoga class.
Maintain a healthy weight: Losing excess weight can significantly lower blood pressure levels. Aim for a body mass index (BMI) within the normal range (18.5-24.9). You can achieve this by combining a healthy diet with regular physical activity.
Limit alcohol consumption: Drinking alcohol in moderation is key. Men should limit themselves to two drinks per day, while women should stick to one drink per day. Excessive alcohol consumption can raise blood pressure levels and have other negative health effects.
Quit smoking: Smoking can raise your blood pressure and damage your blood vessels. Quitting smoking not only benefits your blood pressure but also improves your overall health. Seek support from healthcare professionals or join smoking cessation programs to help you quit successfully.
Manage stress: Chronic stress can contribute to high blood pressure. Find healthy ways to manage stress, such as practicing relaxation techniques, engaging in hobbies, spending time with loved ones, or seeking professional help if needed.
Limit caffeine intake: While the effects of caffeine on blood pressure vary from person to person, it's advisable to limit your caffeine intake. Monitor how your body responds to caffeine and consider reducing your consumption if you notice any adverse effects.
Get enough sleep: Aim for 7-8 hours of quality sleep each night. Poor sleep can contribute to high blood pressure and other health issues. Establish a relaxing bedtime routine, create a comfortable sleep environment, and prioritize sleep as part of your overall well-being.
Monitor your blood pressure: Regularly check your blood pressure at home using a reliable blood pressure monitor. This allows you to track your progress and make necessary adjustments to your lifestyle. Consult with your healthcare provider to establish target blood pressure goals.
''';
        break;
      case PredictionType.diabetes:
        recommendationMessage =
            ''' vegetables. nonstarchy: includes broccoli, carrots, greens, peppers, and tomatoes. ...
fruits—includes oranges, melon, berries, apples, bananas, and grapes.
grains—at least half of your grains for the day should be whole grains. ...
protein. ...
dairy—nonfat or low fat. ''';
        break;
      case PredictionType.cholesterol:
        recommendationMessage =
            '''Eating more plant-based foods like vegetables, legumes, fruit, wholegrains, nuts and seeds is good for heart health. Include legumes (or pulses such as chickpeas, lentils, split peas), beans (such as haricot beans, kidney beans, baked beans , bean mixes) in at least two meals a week.''';
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    generateRecommendation();

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    "Type of condition: ${typeOfPrediction.toDescription()}",
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              const Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    "Recommended Diet:",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  recommendationMessage,
                  textAlign: TextAlign.justify,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
