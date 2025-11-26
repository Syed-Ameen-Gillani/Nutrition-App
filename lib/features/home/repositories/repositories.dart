import 'package:dio/dio.dart';
import 'package:nutrovite/features/home/models/constants.dart';
import 'package:nutrovite/features/home/models/get_neutrant.dart';
import 'package:nutrovite/features/home/models/nutrition_intake.dart';
import 'package:nutrovite/features/home/models/price_model.dart';
import 'package:nutrovite/features/home/models/province_model.dart';

class NutroviteApi {
  // Base URL for the API endpoint
  final String _baseUrl = ServerConstants.baseUrl;

  // Dio instance
  final Dio _dio = Dio();

  // Method to fetch nutrition data from the first API
  Future<NutritionIntakes> fetchNutritionData() async {
    try {
      // Sending a GET request to the first API
      Response response = await _dio.get('$_baseUrl/get');

      // Check if the response status is OK
      if (response.statusCode == 200) {
        // Parsing the JSON response to Nutrovite object
        return NutritionIntakes.fromJson(response.data);
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      // Handling errors
      throw Exception('Error fetching data');
    }
  }

  // Method to fetch nutrient data from the second API
  Future<GetNutrient> fetchNutrientData() async {
    try {
      // Sending a GET request to the second API
      Response response = await _dio.get('$_baseUrl/nutrient');

      // Check if the response status is OK
      if (response.statusCode == 200) {
        // Parsing the JSON response to GetNutrient object
        return GetNutrient.fromJson(response.data);
      } else {
        throw Exception('Failed to load nutrient data: ${response.statusCode}');
      }
    } catch (e) {
      // Handling errors
      throw Exception('Error fetching nutrient data');
    }
  }

  // Method to fetch province data from the third API
  Future<Province> fetchProvinceData() async {
    try {
      // Sending a GET request to the third API
      Response response = await _dio.get('$_baseUrl/provience');

      // Check if the response status is OK
      if (response.statusCode == 200) {
        // Parsing the JSON response to Province object
        return Province.fromJson(response.data);
      } else {
        throw Exception('Failed to load province data: ${response.statusCode}');
      }
    } catch (e) {
      // Handling errors
      throw Exception('Error fetching province data');
    }
  }

  Future<PriceList> fetchPriceListData() async {
    try {
      Response response = await _dio.get('$_baseUrl/all');
      if (response.statusCode == 200) {
        return PriceList.fromJson(response.data);
      } else {
        throw Exception(
            'Failed to load price list data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching price list data');
    }
  }
}
