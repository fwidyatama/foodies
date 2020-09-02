import 'package:flutter/material.dart';
import 'package:meal_catalogue/models/food.dart';
import 'package:meal_catalogue/api/api.dart';
import 'detail_screen.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:meal_catalogue/config.dart';

class Dessert extends StatefulWidget {

  @override
  _DessertState createState() => _DessertState();
}

class _DessertState extends State<Dessert> {
  @override
  void initState() {
    super.initState();
  }

  Widget itemBuilder() {
    return Container(
        child: FutureBuilder<Meals>(
            future: Api.getMealsList('Dessert'),
            builder: (context, AsyncSnapshot<Meals> snapshot) {
              if (snapshot.hasData) {
                return itemList(snapshot);
              } else if (snapshot.hasError) {
                return Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      'assets/cancel.png',
                      scale: 4,
                    ),
                    Text(
                      "Error no internet connection",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18, color: Colors.redAccent),
                    )
                  ],
                ));
              }
              return Center(
                  child: SpinKitThreeBounce(
                color: Config.color,
              ));
            }));
  }

  Widget itemList(AsyncSnapshot<Meals> snapshot) {
    return GridView.builder(
      key: Key('GridView_Dessert'),
        itemCount: snapshot == null ? 0 : snapshot.data.meals.length,
        padding: EdgeInsets.all(10),
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) {
          return GestureDetector(

            child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: GridTile(
                    key: Key("id_"+snapshot.data.meals[index].idMeal.toString()),
                    child: FlatButton(

                  splashColor: Config.color,
                  textTheme: ButtonTextTheme.normal,
                  onPressed: () async {
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text("Selected item is " +
                          snapshot.data.meals[index].strMeal),
                      duration: Duration(seconds: 1),
                    ));
                    await Future.delayed(Duration(seconds: 1));
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailScreen(
                                  idMeal: snapshot.data.meals[index].idMeal,
                                  strMeal: snapshot.data.meals[index].strMeal,
                                  strMealThumb:
                                      snapshot.data.meals[index].strMealThumb,
                                )));
                  },
                  child: Container(
                    padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Hero(
                                tag: snapshot.data.meals[index].strMeal,
                                child: Image.network(
                                  snapshot.data.meals[index].strMealThumb,
                                  fit: BoxFit.fill,
                                ),
                              )),
                          Padding(padding: EdgeInsets.only(top: 5)),
                          Expanded(
                              child: Text(
                            snapshot.data.meals[index].strMeal,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 10),
                          ))
                        ]),
                  ),
                ))),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 1.5;
    return Scaffold(body: Container(child: itemBuilder()));
  }
}
