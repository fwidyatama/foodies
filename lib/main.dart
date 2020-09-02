import 'package:flutter/material.dart';
import 'package:meal_catalogue/views/dessert.dart';
import 'package:meal_catalogue/views/favourite.dart';
import 'package:meal_catalogue/views/seafood.dart';
import 'config.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:meal_catalogue/views/search_view.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Config.appString,
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  final pageSelected = [Dessert(), Seafood(), Favourite()];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primaryColor: Config.color,
        ),
        home: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              Config.appString,
              style: TextStyle(color: Colors.white),
            ),
            leading: IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SearchView()));
                }),
          ),

          body: pageSelected[_selectedIndex],
          bottomNavigationBar: BottomNavyBar(
              showElevation: true,
              key: Key('bottom'),
              onItemSelected: (position) {
                setState(() {
                  _selectedIndex = position;
                });
              },
              selectedIndex: _selectedIndex,
              items: [
                BottomNavyBarItem(
                    icon: Icon(
                      MdiIcons.food,
                    ),
                    title: Text(
                      'Dessert',
                      key: Key('Dessert'),
                    ),
                activeColor: Config.color),
                BottomNavyBarItem(
                    icon: Icon(
                      MdiIcons.foodCroissant,
                    ),
                    title: Text('Seafood', key: Key('Seafood')),activeColor: Config.color),
                BottomNavyBarItem(
                    icon: Icon(
                      MdiIcons.heart,
                      key: Key('Favourite'),
                    ),
                    title: Text('Favourite'),activeColor: Config.color)
              ]),
        ));
  }
}
