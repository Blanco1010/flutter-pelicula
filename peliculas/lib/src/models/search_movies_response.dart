// To parse this JSON data, do
//
//     final searchRepsonse = searchRepsonseFromMap(jsonString);

import 'dart:convert';

import 'package:peliculas/src/models/model.dart';

class SearchRepsonse {
  SearchRepsonse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  int page;
  List<Movie> results;
  int totalPages;
  int totalResults;

  factory SearchRepsonse.fromJson(String str) =>
      SearchRepsonse.fromMap(json.decode(str));

  factory SearchRepsonse.fromMap(Map<String, dynamic> json) => SearchRepsonse(
        page: json["page"],
        results: List<Movie>.from(json["results"].map((x) => Movie.fromMap(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );
}
