import 'package:flutter_test/flutter_test.dart';
import 'package:meal_catalogue/api/api.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:meal_catalogue/models/food.dart';

class ApiTest extends Mock implements http.Client {}

main() {
  final client = ApiTest();

  group("Dessert testing : ", () {
    test("Get all dessert meals", () async {
      when(client.get(
              'https://www.themealdb.com/api/json/v1/1/filter.php?c=Dessert'))
          .thenAnswer((_) async => http.Response(MealsItem().toString(), 200));
      expect(await Api.getMealsList("dessert"), isInstanceOf<Meals>());
    });
    test("Failed request dessert meals", () async {
      when(client.get(
              'https://www.themealdb.com/api/json/v1/1/filter.php?c=Dessert'))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      expect(await Api.getMealsList("dessert"), isInstanceOf<Meals>());
    });
    test("Get detail dessert meals", () async {
      when(client.get(
              'https://www.themealdb.com/api/json/v1/1/lookup.php?i=52891'))
          .thenAnswer((_) async => http.Response(MealsItem().toString(), 200));
      expect(await Api.getDetailMeals("52891"), isInstanceOf<Meals>());
    });
    test("Failed get detail dessert meals", () async {
      when(client.get(
              'https://www.themealdb.com/api/json/v1/1/lookup.php?i=52891'))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      expect(await Api.getDetailMeals("52891"),isInstanceOf<Meals>());
    });
    test("Search dessert meals", () async {
      when(client.get(
              'https://www.themealdb.com/api/json/v1/1/search.php?s=Carrot'))
          .thenAnswer((_) async => http.Response(MealsItem().toString(), 200));
      expect(await Api.searchMeals("Carrot"), isInstanceOf<Meals>());
    });
  });


  group("Seafood testing : ", () {
    test("Get all dessert meals", () async {
      when(client.get(
          'https://www.themealdb.com/api/json/v1/1/filter.php?c=Seafood'))
          .thenAnswer((_) async => http.Response(MealsItem().toString(), 200));
      expect(await Api.getMealsList("seafood"), isInstanceOf<Meals>());
    });
    test("Failed request dessert seafood", () async {
      when(client.get(
          'https://www.themealdb.com/api/json/v1/1/filter.php?c=Seafood'))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      expect(await Api.getMealsList("seafood"), isInstanceOf<Meals>());
    });
    test("Get detail seafood meals", () async {
      when(client.get(
          'https://www.themealdb.com/api/json/v1/1/lookup.php?i=52823'))
          .thenAnswer((_) async => http.Response(MealsItem().toString(), 200));
      expect(await Api.getDetailMeals("52823"), isInstanceOf<Meals>());
    });
    test("Failed get detail seafood meals", () async {
      when(client.get(
          'https://www.themealdb.com/api/json/v1/1/lookup.php?i=52823'))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      expect(await Api.getDetailMeals("52823"), isInstanceOf<Meals>());
    });
    test("Search seafood meals", () async {
      when(client.get(
          'https://www.themealdb.com/api/json/v1/1/search.php?s=Tuna'))
          .thenAnswer((_) async => http.Response(MealsItem().toString(), 200));
      expect(await Api.searchMeals("Tuna"), isInstanceOf<Meals>());
    });
  });
}
