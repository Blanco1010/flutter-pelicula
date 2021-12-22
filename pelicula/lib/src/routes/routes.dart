import 'package:flutter/material.dart';
import 'package:pelicula/src/screens/screens.dart';

final Map<String, Widget Function(BuildContext)> routes =
    <String, WidgetBuilder>{
  'home': (_) => HomeScreen(),
  'details': (_) => DetailsScreen()
};
