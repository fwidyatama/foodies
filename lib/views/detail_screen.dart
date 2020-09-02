import 'package:flutter/material.dart';
import 'package:meal_catalogue/models/food.dart';
import 'package:meal_catalogue/api/api.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:meal_catalogue/local/dbhelper.dart';
import 'package:oktoast/oktoast.dart';
import 'package:meal_catalogue/config.dart';

class DetailScreen extends StatefulWidget {
  final String strMeal;
  final String strMealThumb;
  final String idMeal;

  DetailScreen({Key key,this.strMeal, this.strMealThumb, this.idMeal}) :super (key:key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool _isFavourite = false;
  @override
  void initState() {
    super.initState();

    Api.getDetailMeals(widget.idMeal);
    DbHelper.dbHelper.checkFavourite(widget.idMeal).then((value) {
      setState(() {
        _isFavourite = value != null;
      });
    });
  }

  Widget itemBuilder() {
    return Container(
        child: FutureBuilder<Meals>(
            future: Api.getDetailMeals(widget.idMeal),
            builder: (context, AsyncSnapshot<Meals> snapshot) {
              if (snapshot.hasData) {
                return showDetail(snapshot);
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              return Center(
                  child: SpinKitThreeBounce(
                color: Config.color,
              ));
            }));
  }

  Widget showDetail(AsyncSnapshot<Meals> snapshot) {
    return NestedScrollView(
        headerSliverBuilder: (context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              floating: false,
              expandedHeight: 275,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.parallax,
                background: Hero(
                    tag: widget.strMeal,
                    child: Image.network(
                      widget.strMealThumb,
                      fit: BoxFit.cover,
                    )),
              ),
              leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  key: Key('back_button'),
                  onPressed: () {
                    Navigator.pop(context, false);
                  }),
            )
          ];
        },
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        child: Text(widget.strMeal,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 27.0,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                      Text(
                        "Category : " + snapshot.data.meals[0].strCategory,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 5),
                      ),
                      Text(
                        "Ingredients : ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 7),
                        child: Text(
                          "- " +
                              snapshot.data.meals[0].strIngredient1 +
                              "\n" +
                              "- " +
                              snapshot.data.meals[0].strIngredient2 +
                              "\n" +
                              "- " +
                              snapshot.data.meals[0].strIngredient3 +
                              "\n" +
                              "- " +
                              snapshot.data.meals[0].strIngredient4 +
                              "\n" +
                              "- " +
                              snapshot.data.meals[0].strIngredient5,
                          style: TextStyle(fontSize: 15),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                      ),
                      Text(
                        "Instruction : ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Text(
                        snapshot.data.meals[0].strInstructions,
                        style: TextStyle(fontSize: 15),
                        textAlign: TextAlign.justify,
                      )
                    ],
                  ))
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return OKToast(
        child: Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Config.color,
        onPressed: () {
          if (_isFavourite) {
            DbHelper.dbHelper.deleteFavourite(widget.idMeal).then((value) {
              if (value != 0) {
                setState(() {
                  _isFavourite = false;
                });
              }
            });
            showToast("Removed ${widget.strMeal} From Favourite",
                position: ToastPosition.bottom,
                backgroundColor: Colors.grey,
                textPadding: EdgeInsets.all(10));

          } else {
            MealsItem mealsFavourite = MealsItem(
                idMeal: widget.idMeal,
                strMeal: widget.strMeal,
                strMealThumb: widget.strMealThumb);
            DbHelper.dbHelper.addFavourite(mealsFavourite).then((value) {
              if (value != 0) {
                setState(() {
                  _isFavourite = true;
                });
              }
            });

            showToast("Added ${widget.strMeal}  Favourite",
                position: ToastPosition.bottom,
                backgroundColor: Colors.grey,
                textPadding: EdgeInsets.all(10));
          }
        },
        child:
            _isFavourite ? Icon(MdiIcons.heart) : Icon(MdiIcons.heartOutline),
        key: Key("favourite_"+widget.idMeal),
      ),
      body: itemBuilder(),
    ));
  }

}
