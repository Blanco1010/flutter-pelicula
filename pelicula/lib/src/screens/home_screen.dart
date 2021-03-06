import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:pelicula/src/providers/movies_provider.dart';
import 'package:pelicula/src/widgets/widgets.dart';

import 'package:pelicula/src/search/search_delegate.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: true);

    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Películas en cines'),
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () => showSearch(
                context: context, delegate: MovieSearchDelegate(size)),
          )
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            // CardSwpier
            CardSwiper(movies: moviesProvider.onDisplayMoviesList),

            //List of movies.
            SizedBox(height: size.height * 0.02),
            MovieSlider(
              onNextPage: () => moviesProvider.getPopularMovies(),
              movies: moviesProvider.popularMoviesList,
              title: 'Populares',
            ),
            Divider(),
            MovieSlider(
              onNextPage: () => moviesProvider.getUpComingMovies(),
              movies: moviesProvider.upComingMoviesList,
              title: 'Próximo',
            ),
          ],
        ),
      ),
    );
  }
}
