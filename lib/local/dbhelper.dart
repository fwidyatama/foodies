import 'dart:io';
import 'package:meal_catalogue/models/food.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static final DbHelper dbHelper = DbHelper.internal();
  DbHelper.internal();
  static Database _database;

  Future<Database> get dataBase async {
    if (_database != null) {
      return _database;
    }
    _database = await makeDB();
    return _database;
  }

  makeDB() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "MealsDb");
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE favourite(id INTEGER PRIMARY KEY, idMeal TEXT, strMeal TEXT, strMealThumb TEXT, strCategory TEXT, strInstructions TEXT, strIngredient1 TEXT, strIngredient2 TEXT, strIngredient3 TEXT, strIngredient4 TEXT, strIngredient5 TEXT)");
    print("DB Created");
  }

  Future<List<MealsItem>> getAllFavourite() async {
    var dbClient = await dataBase;
    var res =
        await dbClient.rawQuery("SELECT * FROM favourite ORDER BY id DESC");
    List<MealsItem> mealsResult =
        res.isEmpty ? [] : res.map((item) => MealsItem.fromJson(item)).toList();
    print("Sucess show all");
    return mealsResult;
  }

  Future<int> addFavourite(MealsItem mealsItem) async {
    final dbClient = await dataBase;
    var res = await dbClient.insert("favourite", mealsItem.toJson());
    print("Data Inserted");
    return res;
  }

  Future<int> deleteFavourite(String id) async {
    var dbClient = await dataBase;
    var res =
        await dbClient.delete("favourite", where: "idMeal=?", whereArgs: [id]);
    print("Data deleted");
    return res;
  }

  Future<MealsItem> checkFavourite(String idMeal) async {
    final dbClient = await dataBase;
    var res = await dbClient
        .query("favourite", where: "idMeal = ?", whereArgs: [idMeal]);
    return res.isEmpty ? null : MealsItem.fromJson(res.first);
  }
}
