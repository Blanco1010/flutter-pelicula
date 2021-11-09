import 'package:flutter/material.dart';

class MovieSearchDelegate extends SearchDelegate {
  final Size size;

  MovieSearchDelegate(this.size);

  @override
  String? get searchFieldLabel => 'Buscar película';

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear),
        splashRadius: 20,
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text('buildResults');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return SafeArea(
        child: Center(
          child: Icon(
            Icons.movie_creation_outlined,
            size: 300,
            color: Colors.black,
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}
