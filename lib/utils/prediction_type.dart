enum PredictionType {
  cholesterol,
  diabetes,
  bloodPressure,
}

extension PredictionTypeExtension on PredictionType {
  String toDescription() {
    switch (this) {
      case PredictionType.cholesterol:
        return 'High Cholesterol';
      case PredictionType.diabetes:
        return 'Diabetic';
      case PredictionType.bloodPressure:
        return 'High Blood Pressure';
      default:
        return ''; // Handle unknown enum values
    }
  }
}
