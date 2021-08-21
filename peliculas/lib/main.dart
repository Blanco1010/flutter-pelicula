import 'package:flutter/material.dart';
import 'package:peliculas/src/routes/routes.dart';

import 'src/themes/theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movies',
      initialRoute: 'home',
      routes: routes,
      theme: theme,
    );
  }
}
