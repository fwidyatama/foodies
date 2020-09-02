import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';


void main(){
  FlutterDriver flutterDriver;

  setUpAll(()async{
    flutterDriver = await FlutterDriver.connect();
  });

  tearDownAll(() async{
    if(flutterDriver!=null){
      flutterDriver.close();
    }
  });


  test("Dessert Meals",() async{
    await flutterDriver.waitFor(find.byValueKey('bottom'));
    await flutterDriver.tap(find.byValueKey('Dessert'));
    await flutterDriver.waitFor(find.byValueKey('GridView_Dessert'));
    await Future.delayed(Duration(seconds: 1));
    await flutterDriver.scroll(find.byValueKey('GridView_Dessert'), 0, 300, Duration(milliseconds: 500));
    await flutterDriver.scroll(find.byValueKey('GridView_Dessert'), 0, -500, Duration(milliseconds: 500));
    await flutterDriver.scroll(find.byValueKey('GridView_Dessert'), 0, 700, Duration(milliseconds: 500));
    await Future.delayed(Duration(seconds: 1));
    await flutterDriver.tap(find.byValueKey("id_52768"));
    await flutterDriver.tap(find.byValueKey("favourite_52768"));
    await Future.delayed(Duration(seconds: 1));
    await flutterDriver.tap(find.byValueKey('back_button'));
    await flutterDriver.waitFor(find.byValueKey('bottom'));
  });

  test("Seafood Meals",() async{
    await flutterDriver.waitFor(find.byValueKey('bottom'));
    await flutterDriver.tap(find.byValueKey('Seafood'));
    await flutterDriver.waitFor(find.byValueKey('GridView_Seafood'));
    await Future.delayed(Duration(seconds: 1));
    await flutterDriver.scroll(find.byValueKey('GridView_Seafood'), 0, 300, Duration(milliseconds: 500));
    await flutterDriver.scroll(find.byValueKey('GridView_Seafood'), 0, -500, Duration(milliseconds: 500));
    await flutterDriver.scroll(find.byValueKey('GridView_Seafood'), 0, 700, Duration(milliseconds: 500));
    await Future.delayed(Duration(seconds: 1));
    await flutterDriver.tap(find.byValueKey("id_52819"));
    await flutterDriver.tap(find.byValueKey("favourite_52819"));
    await Future.delayed(Duration(seconds: 1));
    await flutterDriver.tap(find.byValueKey('back_button'));
    await flutterDriver.waitFor(find.byValueKey('bottom'));
  });

  test("See favourite Meals",() async{
    await flutterDriver.waitFor(find.byValueKey('bottom'));
    await flutterDriver.tap(find.byValueKey('Favourite'));
    await flutterDriver.waitFor(find.byValueKey('Favourite_Meals'));
    await Future.delayed(Duration(seconds: 1));
    await flutterDriver.scroll(find.byValueKey('Favourite_Meals'), 0, 300, Duration(milliseconds: 500));
    await flutterDriver.scroll(find.byValueKey('Favourite_Meals'), 0, -500, Duration(milliseconds: 500));
    await flutterDriver.scroll(find.byValueKey('Favourite_Meals'), 0, 700, Duration(milliseconds: 500));

  });

  test("Remove list favourite",()async{
    await flutterDriver.waitFor(find.byValueKey('bottom'));
    await flutterDriver.tap(find.byValueKey('Favourite'));
    await flutterDriver.waitFor(find.byValueKey('Favourite_Meals'));
    await Future.delayed(Duration(seconds: 1));
    await flutterDriver.tap(find.byValueKey("id_52819"));
    await flutterDriver.tap(find.byValueKey("favourite_52819"));
    await Future.delayed(Duration(seconds: 1));
    await flutterDriver.tap(find.byValueKey('back_button'));
    await flutterDriver.waitFor(find.byValueKey('bottom'));
  });


  test("Navbar Testing",() async{
    await flutterDriver.waitFor(find.byValueKey('bottom'));
    await flutterDriver.tap(find.byValueKey('Dessert'));
    await flutterDriver.waitFor(find.byValueKey('GridView_Dessert'));
    await Future.delayed(Duration(seconds: 1));
    await flutterDriver.tap(find.byValueKey('Seafood'));
    await flutterDriver.waitFor(find.byValueKey('GridView_Seafood'));
    await Future.delayed(Duration(seconds: 1));
    await flutterDriver.tap(find.byValueKey('Favourite'));
    await flutterDriver.waitFor(find.byValueKey('Favourite_Meals'));
    await Future.delayed(Duration(seconds: 1));
  });
  

}