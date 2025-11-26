/// Service for calculating nutrition recommendations based on scientific guidelines
class NutritionRecommendationService {
  /// Generate nutrition recommendations based on RDA/DRI guidelines
  static Map<String, double> generateRecommendations({
    required int age,
    required String gender,
    required String lactationStatus,
    String activityLevel = 'moderate', // New parameter
    List<String> healthConditions = const [], // New parameter
  }) {
    // Validate inputs
    if (age < 0 || age > 120) {
      throw ArgumentError('Invalid age: $age. Age must be between 0 and 120.');
    }
    
    final baseRecommendations = _getBaseRecommendations(age, gender);
    final adjustedRecommendations = _adjustForSpecialConditions(
      baseRecommendations,
      lactationStatus,
      activityLevel,
      healthConditions,
    );
    
    return adjustedRecommendations;
  }

  /// Get base recommendations by age and gender (RDA/DRI based)
  static Map<String, double> _getBaseRecommendations(int age, String gender) {
    final recommendations = <String, double>{
      'Iron': 0,
      'Fiber': 0,
      'Calcium': 0,
      'Omega-3 Fatty Acids': 0,
      'Vitamin D': 0,
      'Vitamin E': 0,
      'Vitamin B12': 0,
      'Water': 0,
      'Magnesium': 0,
      'Potassium': 0,
    };

    // Age-based recommendations following RDA guidelines
    if (age < 1) {
      recommendations.addAll(_getInfantRecommendations(age));
    } else if (age >= 1 && age <= 3) {
      recommendations.addAll(_getToddlerRecommendations());
    } else if (age >= 4 && age <= 8) {
      recommendations.addAll(_getChildRecommendations());
    } else if (age >= 9 && age <= 13) {
      recommendations.addAll(_getPreteenRecommendations(gender));
    } else if (age >= 14 && age <= 18) {
      recommendations.addAll(_getTeenRecommendations(gender));
    } else if (age >= 19 && age <= 50) {
      recommendations.addAll(_getAdultRecommendations(gender));
    } else if (age >= 51 && age <= 70) {
      recommendations.addAll(_getMiddleAgedRecommendations(gender));
    } else if (age > 70) {
      recommendations.addAll(_getElderlyRecommendations(gender));
    }

    return recommendations;
  }

  /// Adjust recommendations for special conditions
  static Map<String, double> _adjustForSpecialConditions(
    Map<String, double> base,
    String lactationStatus,
    String activityLevel,
    List<String> healthConditions,
  ) {
    final adjusted = Map<String, double>.from(base);

    // Pregnancy adjustments
    if (lactationStatus == 'Pregnancy') {
      adjusted['Iron'] = 27.0; // Increased iron during pregnancy
      adjusted['Calcium'] = 1300.0;
      adjusted['Omega-3 Fatty Acids'] = 1.4;
      adjusted['Vitamin D'] = 600.0;
      adjusted['Vitamin E'] = 15.0;
      adjusted['Vitamin B12'] = 2.6;
      adjusted['Water'] = 3.0;
      adjusted['Magnesium'] = 350.0;
      adjusted['Potassium'] = 2900.0;
      adjusted['Fiber'] = (adjusted['Fiber'] ?? 0) + 3; // Increase fiber
    }

    // Lactation adjustments
    if (lactationStatus == 'Lactation') {
      adjusted['Iron'] = 9.0;
      adjusted['Calcium'] = 1000.0;
      adjusted['Vitamin D'] = 600.0;
      adjusted['Vitamin E'] = 19.0;
      adjusted['Vitamin B12'] = 2.8;
      adjusted['Water'] = 3.8;
      adjusted['Magnesium'] = 310.0;
      adjusted['Potassium'] = 3100.0;
    }

    // Activity level adjustments
    switch (activityLevel.toLowerCase()) {
      case 'high':
        adjusted['Water'] = (adjusted['Water'] ?? 0) * 1.2;
        adjusted['Magnesium'] = (adjusted['Magnesium'] ?? 0) * 1.1;
        adjusted['Potassium'] = (adjusted['Potassium'] ?? 0) * 1.1;
        break;
      case 'low':
        adjusted['Water'] = (adjusted['Water'] ?? 0) * 0.9;
        break;
    }

    return adjusted;
  }

  // Age-specific recommendation methods
  static Map<String, double> _getInfantRecommendations(int ageMonths) {
    if (ageMonths <= 6) {
      return {
        'Iron': 0.27,
        'Fiber': 0, // Not applicable for infants
        'Calcium': 200.0,
        'Omega-3 Fatty Acids': 0.5,
        'Vitamin D': 400.0,
        'Vitamin E': 4.0,
        'Vitamin B12': 0.4,
        'Water': 0.7,
        'Magnesium': 30.0,
        'Potassium': 400.0,
      };
    } else {
      return {
        'Iron': 11.0,
        'Fiber': 5.0, // AI for 7-12 months
        'Calcium': 260.0,
        'Omega-3 Fatty Acids': 0.5,
        'Vitamin D': 400.0,
        'Vitamin E': 5.0,
        'Vitamin B12': 0.5,
        'Water': 0.8,
        'Magnesium': 75.0,
        'Potassium': 700.0,
      };
    }
  }

  static Map<String, double> _getToddlerRecommendations() {
    return {
      'Iron': 7.0,
      'Fiber': 19.0,
      'Calcium': 700.0,
      'Omega-3 Fatty Acids': 0.7,
      'Vitamin D': 600.0,
      'Vitamin E': 6.0,
      'Vitamin B12': 0.9,
      'Water': 1.3,
      'Magnesium': 80.0,
      'Potassium': 2000.0,
    };
  }

  static Map<String, double> _getChildRecommendations() {
    return {
      'Iron': 10.0,
      'Fiber': 25.0,
      'Calcium': 1000.0,
      'Omega-3 Fatty Acids': 0.9,
      'Vitamin D': 600.0,
      'Vitamin E': 7.0,
      'Vitamin B12': 1.2,
      'Water': 1.7,
      'Magnesium': 130.0,
      'Potassium': 2300.0,
    };
  }

  static Map<String, double> _getPreteenRecommendations(String gender) {
    return {
      'Iron': gender.toLowerCase() == 'female' ? 8.0 : 8.0,
      'Fiber': gender.toLowerCase() == 'female' ? 26.0 : 31.0,
      'Calcium': 1300.0,
      'Omega-3 Fatty Acids': 1.0,
      'Vitamin D': 600.0,
      'Vitamin E': 11.0,
      'Vitamin B12': 1.8,
      'Water': 2.1,
      'Magnesium': 240.0,
      'Potassium': 2500.0,
    };
  }

  static Map<String, double> _getTeenRecommendations(String gender) {
    return {
      'Iron': gender.toLowerCase() == 'female' ? 15.0 : 11.0,
      'Fiber': gender.toLowerCase() == 'female' ? 26.0 : 38.0,
      'Calcium': 1300.0,
      'Omega-3 Fatty Acids': gender.toLowerCase() == 'female' ? 1.1 : 1.6,
      'Vitamin D': 600.0,
      'Vitamin E': 15.0,
      'Vitamin B12': 2.4,
      'Water': gender.toLowerCase() == 'female' ? 2.3 : 3.3,
      'Magnesium': gender.toLowerCase() == 'female' ? 360.0 : 410.0,
      'Potassium': 3000.0,
    };
  }

  static Map<String, double> _getAdultRecommendations(String gender) {
    return {
      'Iron': gender.toLowerCase() == 'female' ? 18.0 : 8.0,
      'Fiber': gender.toLowerCase() == 'female' ? 25.0 : 38.0,
      'Calcium': 1000.0,
      'Omega-3 Fatty Acids': gender.toLowerCase() == 'female' ? 1.1 : 1.6,
      'Vitamin D': 600.0,
      'Vitamin E': 15.0,
      'Vitamin B12': 2.4,
      'Water': gender.toLowerCase() == 'female' ? 2.7 : 3.7,
      'Magnesium': gender.toLowerCase() == 'female' ? 310.0 : 400.0,
      'Potassium': 3500.0,
    };
  }

  static Map<String, double> _getMiddleAgedRecommendations(String gender) {
    return {
      'Iron': gender.toLowerCase() == 'female' ? 8.0 : 8.0, // Post-menopause
      'Fiber': gender.toLowerCase() == 'female' ? 21.0 : 30.0,
      'Calcium': 1200.0, // Increased for bone health
      'Omega-3 Fatty Acids': gender.toLowerCase() == 'female' ? 1.1 : 1.6,
      'Vitamin D': 600.0,
      'Vitamin E': 15.0,
      'Vitamin B12': 2.4,
      'Water': gender.toLowerCase() == 'female' ? 2.7 : 3.7,
      'Magnesium': gender.toLowerCase() == 'female' ? 320.0 : 420.0,
      'Potassium': 3500.0,
    };
  }

  static Map<String, double> _getElderlyRecommendations(String gender) {
    return {
      'Iron': 8.0,
      'Fiber': gender.toLowerCase() == 'female' ? 21.0 : 30.0,
      'Calcium': 1200.0,
      'Omega-3 Fatty Acids': gender.toLowerCase() == 'female' ? 1.1 : 1.6,
      'Vitamin D': 800.0, // Increased for elderly
      'Vitamin E': 15.0,
      'Vitamin B12': 2.4,
      'Water': gender.toLowerCase() == 'female' ? 2.7 : 3.7,
      'Magnesium': gender.toLowerCase() == 'female' ? 320.0 : 420.0,
      'Potassium': 3500.0,
    };
  }

  /// Get nutrient status (deficient, adequate, excessive)
  static Map<String, String> getNutrientStatus(
    Map<String, double> recommended,
    Map<String, double> consumed,
  ) {
    final status = <String, String>{};
    
    for (final nutrient in recommended.keys) {
      final rec = recommended[nutrient] ?? 0;
      final cons = consumed[nutrient] ?? 0;
      final percentage = rec > 0 ? (cons / rec) * 100 : 0;
      
      if (percentage < 67) {
        status[nutrient] = 'Deficient';
      } else if (percentage >= 67 && percentage <= 133) {
        status[nutrient] = 'Adequate';
      } else {
        status[nutrient] = 'Excessive';
      }
    }
    
    return status;
  }
}
