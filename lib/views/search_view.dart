import 'package:flutter/material.dart';
import 'package:meal_catalogue/models/food.dart';
import 'package:meal_catalogue/api/api.dart';
import 'detail_screen.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SearchView extends StatefulWidget {
  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  TextEditingController _query = TextEditingController();

  @override
  void initState() {
    super.initState();
    Api.searchMeals("");
  }

  Widget itemBuilder() {
    return Container(
        child: FutureBuilder<Meals>(
            future: Api.searchMeals(_query.text),
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
                    Padding(padding: EdgeInsets.all(8),child: Text(
                      "No Result..",
                      textAlign: TextAlign.center,

                      style: TextStyle(fontSize: 18, color: Colors.black54),
                    ),)
                  ],
                ));
              }
              return Center(
                  child: SpinKitThreeBounce(
                color: Colors.lightBlueAccent,
              ));
            }));
  }

  Widget itemList(AsyncSnapshot<Meals> snapshot) {
    return GridView.builder(
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
                    child: FlatButton(
                  splashColor: Colors.indigo,
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
    return MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.lightBlueAccent,
        ),
        home: Scaffold(
            body: Container(child: itemBuilder()),
            appBar: AppBar(
              leading: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context, false);
                  }),
              title: TextField(
                controller: _query,
                autofocus: true,
                style: TextStyle(fontSize: 17, color: Colors.white),
                decoration: InputDecoration.collapsed(
                  hintText: "Search meals name ...",
                  hintStyle: TextStyle(fontSize: 17, color: Colors.white),
                ),
              ),
            )));
  }
}
