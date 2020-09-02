import 'package:flutter/material.dart';

import 'config.dart';
import 'main.dart';

void main() {
  Config.appFlavor = Flavor.Pro;
  return runApp(MyApp());
}