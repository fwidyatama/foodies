import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:meal_catalogue/models/food.dart';

class Api {
  static final String _baseUrl = 'https://www.themealdb.com/api/json/v1/1/';

  static Future<Meals> getMealsList(String mealsType) async {
    final response =
        await http.Client().get(_baseUrl + "filter.php?c=$mealsType");
    if (response.statusCode == 200) {
      var parsedResponse = Meals.fromJson(json.decode(response.body));
      return parsedResponse;
    } else {
      throw Exception('Failed to load data');
    }
  }

  static Future<Meals> getDetailMeals(String mealsId) async {
    final response =
        await http.Client().get(_baseUrl + 'lookup.php?i=$mealsId');
    if (response.statusCode == 200) {
      var parsedResponse = Meals.fromJson(json.decode(response.body));
      return parsedResponse;
    } else {
      throw Exception('Failed to load data');
    }
  }

  static Future<Meals> searchMeals(String mealsName) async{
    final response =
    await http.Client().get(_baseUrl + 'search.php?s=$mealsName');
    if (response.statusCode == 200) {
      var parsedResponse = Meals.fromJson(json.decode(response.body));
      return parsedResponse;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
