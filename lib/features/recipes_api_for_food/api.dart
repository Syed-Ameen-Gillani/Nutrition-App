import 'package:dio/dio.dart';
import 'package:nutrovite/features/recipes_api_for_food/model_recipes.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<List<Recipes>> fetchRecipes() async {
    try {
      final response = await _dio.get('https://dummyjson.com/recipes');

      if (response.statusCode == 200) {
        // ignore: avoid_print
        print(response.runtimeType);
        final List<dynamic> recipesJson = response.data['recipes'];
        return recipesJson.map((json) => Recipes.fromJson(json)).toList();
      } else {
        throw Exception(
            'Failed to load price list data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching price list data');
    }
  }
}
