import 'package:flutter/material.dart';

enum Flavor {
  Dev,
  Pro,
}

class Config {
  static Flavor appFlavor;

  static String get appString {
    switch (appFlavor) {
      case Flavor.Dev:
        return 'Meals Catalogue Debug';
        break;
      case Flavor.Pro:
        return 'Meals Catalogue Release';
        break;
      default:
        return 'Meals Catalogue';
        break;
    }
  }

  static Color get color {
    switch (appFlavor) {
      case Flavor.Dev:
        return Colors.deepPurpleAccent;
        break;
      case Flavor.Pro:
        return Colors.deepOrangeAccent;
        break;
      default:
        return Colors.indigoAccent;
        break;
    }
  }


}
