import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:palette_generator/palette_generator.dart';
import 'package:peliculas/src/helpers/debouncer.dart';
import 'package:peliculas/src/models/model.dart';
import 'package:peliculas/src/models/search_movies_response.dart';

class MoviesProvider with ChangeNotifier {
  String _apiKey = '15bb9b1e64ba5bf01cd84362508d80d1';
  String _baseUrl = 'api.themoviedb.org';
  String _language = 'es-ES';

  List<Movie> onDisplayMoviesList = [];
  List<Movie> upComingMoviesList = [];
  List<Movie> popularMoviesList = [];

  Map<int, List<Cast>> moviesCast = {};

  int _popularPage = 0;
  int _upComingPage = 0;

  final debouncer = Debouncer(
    duration: Duration(microseconds: 500),
  );

  final StreamController<List<Movie>> _suggestionStreamController =
      new StreamController.broadcast();

  Stream<List<Movie>> get suggestionStream =>
      this._suggestionStreamController.stream;

// When initializing, call some methods
  MoviesProvider() {
    print('MoviesProvider inicializado');
    this.getOnDisplayMovies();
    this.getPopularMovies();
    this.getUpComingMovies();
  }

  Future<String> _getJsonData(String endpoint, int page) async {
    final url = Uri.https(_baseUrl, endpoint, {
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
    onDisplayMoviesList = nowplayingresponse.results;
    notifyListeners();
  }

  getUpComingMovies() async {
    _upComingPage++;
    final jsonData = await _getJsonData('3/movie/upcoming', _upComingPage);
    final upComingMovies = UpcomingMovieResponse.fromJson(jsonData);
    upComingMoviesList = [...upComingMoviesList, ...upComingMovies.results];
    notifyListeners();
  }

  getPopularMovies() async {
    _popularPage++;
    // print(_popularPage);
    final jsonData = await _getJsonData('3/movie/popular', _popularPage);

    final popularMoviesResponse = PopularMovieResponse.fromJson(jsonData);
    popularMoviesList = [
      ...popularMoviesList,
      ...popularMoviesResponse.results
    ];
    notifyListeners();
  }

  Future<List<Cast>> getMoviesCast(int movieId) async {
    print('pidiendo info al servidor - Cast');

    if (moviesCast.containsKey(movieId)) return moviesCast[movieId]!;

    final jsonData = await this._getJsonData('3/movie/$movieId/credits', 1);
    final creditsResponse = CreditsRepsonse.fromJson(jsonData);
    moviesCast[movieId] = creditsResponse.cast;
    return creditsResponse.cast;
  }

  Future<List<Movie>> searchMovie(String query) async {
    final url = Uri.https(_baseUrl, '3/search/movie', {
      'api_key': _apiKey,
      'language': _language,
      'query': query,
    });

    final response = await http.get(url);
    final searchResponse = SearchRepsonse.fromJson(response.body);
    return searchResponse.results;
  }

  void getSuggestionByQuery(String searchTerm) {}
}

class ColorAppBar with ChangeNotifier {
  Color colorAppbar = Colors.indigo;

  getColorFromImg(String imageProvider) async {
    final PaletteGenerator paletteGenerator =
        await PaletteGenerator.fromImageProvider(NetworkImage(imageProvider));
    colorAppbar = paletteGenerator.dominantColor!.color;
    notifyListeners();
  }
}
