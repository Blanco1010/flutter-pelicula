import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas/src/models/model.dart';

class MoviesProvider with ChangeNotifier {
  String _apiKey = '15bb9b1e64ba5bf01cd84362508d80d1';
  String _baseUrl = 'api.themoviedb.org';
  String _language = 'es-ES';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];

  MoviesProvider() {
    print('MoviesProvider inicializado');
    this.getOnDisplayMovies();
    this.getPopularMovies();
  }

  getOnDisplayMovies() async {
    var url = Uri.https(_baseUrl, '3/movie/now_playing', {
      'api_key': _apiKey,
      'language': _language,
      'page': '1',
    });

    final response = await http.get(url);

    final nowplayingresponse = NowPlayingResponse.fromJson(response.body);

    onDisplayMovies = nowplayingresponse.results;
    notifyListeners();
  }

  getPopularMovies() async {
    var url = Uri.https(_baseUrl, '3/movie/popular', {
      'api_key': _apiKey,
      'language': _language,
      'page': '1',
    });

    final response = await http.get(url);

    final popularMoviesResponse = PopularMovieResponse.fromJson(response.body);

    popularMovies = [...popularMovies, ...popularMoviesResponse.results];

    notifyListeners();
  }
}
