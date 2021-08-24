import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas/src/models/model.dart';

class MoviesProvider with ChangeNotifier {
  String _apiKey = '15bb9b1e64ba5bf01cd84362508d80d1';
  String _baseUrl = 'api.themoviedb.org';
  String _language = 'es-ES';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];

  int _popularPage = 0;

  MoviesProvider() {
    print('MoviesProvider inicializado');
    this.getOnDisplayMovies();
    this.getPopularMovies();
  }

  Future<String> _getJsonData(String endpoint, int page) async {
    var url = Uri.https(_baseUrl, endpoint, {
      'api_key': _apiKey,
      'language': _language,
      'page': '$page',
    });

    final response = await http.get(url);
    return response.body;
  }

  getOnDisplayMovies() async {
    final jsonData = await _getJsonData('3/movie/now_playing', 1);

    final nowplayingresponse = NowPlayingResponse.fromJson(jsonData);
    onDisplayMovies = nowplayingresponse.results;
    notifyListeners();
  }

  getPopularMovies() async {
    _popularPage++;

    final jsonData = await _getJsonData('3/movie/popular', _popularPage);

    final popularMoviesResponse = PopularMovieResponse.fromJson(jsonData);
    popularMovies = [...popularMovies, ...popularMoviesResponse.results];
    notifyListeners();
  }
}
