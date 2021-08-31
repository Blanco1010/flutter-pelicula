import 'dart:convert';

import 'package:peliculas/src/models/movie.dart';

class UpcomingMovieResponse {
  UpcomingMovieResponse({
    required this.dates,
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  String dates;
  int page;
  List<Movie> results;
  int totalPages;
  int totalResults;

  factory UpcomingMovieResponse.fromJson(String str) =>
      UpcomingMovieResponse.fromMap(json.decode(str));

  factory UpcomingMovieResponse.fromMap(Map<String, dynamic> json) =>
      UpcomingMovieResponse(
        dates: json["dates"].toString(),
        page: json["page"],
        results: List<Movie>.from(json["results"].map((x) => Movie.fromMap(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );
}
