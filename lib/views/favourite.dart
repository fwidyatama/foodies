import 'package:flutter/material.dart';
import 'package:meal_catalogue/models/food.dart';
import 'package:meal_catalogue/local/dbhelper.dart';
import 'detail_screen.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:meal_catalogue/config.dart';

class Favourite extends StatefulWidget {
  @override
  _FavouriteState createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  Future<List<MealsItem>> _favouriteList;

  @override
  void initState() {
    super.initState();
    getListFavourite();
  }

  void getListFavourite(){
   setState(() {
     _favouriteList = DbHelper.dbHelper.getAllFavourite();
   });

  }


  Widget itemBuilder() {
    return Container(
        child: FutureBuilder(
            initialData: <MealsItem>[],
            future: _favouriteList,
            builder: (context, AsyncSnapshot<List<MealsItem>> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.data.isEmpty) {
                  return Center(
                      child: Text(
                    "Empty Data",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ));
                }
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
                color:Config.color ,
              ));
            }));
  }

  Widget itemList(AsyncSnapshot<List<MealsItem>> snapshot) {
    return GridView.builder(
        key: Key('Favourite_Meals'),
        itemCount: snapshot == null ? 0 : snapshot.data.length,
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
                    key: Key("id_"+snapshot.data[index].idMeal.toString()),
                    child: FlatButton(
                  splashColor: Colors.indigo,
                  textTheme: ButtonTextTheme.normal,
                  onPressed: () async {
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text(
                          "Selected item is " + snapshot.data[index].strMeal),
                      duration: Duration(seconds: 1),
                    ));
                    await Future.delayed(Duration(seconds: 1));
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailScreen(
                                  idMeal: snapshot.data[index].idMeal,
                                  strMeal: snapshot.data[index].strMeal,
                                  strMealThumb:
                                      snapshot.data[index].strMealThumb,
                                )));
                  },
                  child: Container(
                    padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.network(
                              snapshot.data[index].strMealThumb,
                              fit: BoxFit.fill,
                            ),
                          ),
                          Padding(padding: EdgeInsets.only(top: 5)),
                          Expanded(
                              child: Text(
                            snapshot.data[index].strMeal,
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
    getListFavourite();
    return Scaffold(body: Container(child: itemBuilder()));
  }
}
