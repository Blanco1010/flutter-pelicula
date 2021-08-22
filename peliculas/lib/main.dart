import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:peliculas/src/routes/routes.dart';

import 'src/themes/theme.dart';

void main() {
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movies',
      initialRoute: 'home',
      routes: routes,
      theme: theme,
    );
  }
}
