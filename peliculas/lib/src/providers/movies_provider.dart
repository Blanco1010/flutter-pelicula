import 'package:flutter/cupertino.dart';

class MoviesProvider with ChangeNotifier {
  MoviesProvider() {
    print('MoviesProvider inicializado');
    this.getOnDisplayMovies();
  }

  getOnDisplayMovies() async {
    print('getOnDisplayMovies');
  }
}
