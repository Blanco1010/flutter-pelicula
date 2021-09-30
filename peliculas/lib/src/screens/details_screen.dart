import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import 'package:peliculas/src/models/movie.dart';
import 'package:peliculas/src/providers/movies_provider.dart';
import 'package:peliculas/src/widgets/widgets.dart';
import 'package:provider/provider.dart';

class DetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //then change to an instance of movie
    final Movie movie = ModalRoute.of(context)?.settings.arguments as Movie;

    return Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          _CustomAppBar(movie: movie),
          SliverList(
            delegate: SliverChildListDelegate([
              _PosterAndTitle(movie: movie),
              _OverView(description: movie.overview),
              CastingCards(movieId: movie.id),
            ]),
          ),
        ],
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  final Movie movie;

  const _CustomAppBar({required this.movie});
  @override
  Widget build(BuildContext context) {
// Calculate dominant color from ImageProvider

    final size = MediaQuery.of(context).size;

    return SliverAppBarWidget(
      size: size,
      movie: movie,
      color: Colors.indigo,
    );

    // It's not so efficient to make this code

    // return FutureBuilder(
    //   future: getImagePalette(movie.fullBackdropPath),
    //   builder: (BuildContext context, AsyncSnapshot<Color> snapshot) {
    //     Color color = Colors.indigo;
    //     if (snapshot.hasData) {
    //       color = snapshot.data!;
    //     }

    //     return SliverAppBarWidget(
    //       size: size,
    //       movie: movie,
    //       color: color,
    //     );
    //   },
    // );
  }
}

class SliverAppBarWidget extends StatelessWidget {
  const SliverAppBarWidget({
    Key? key,
    required this.size,
    required this.movie,
    required this.color,
  }) : super(key: key);

  final Size size;
  final Movie movie;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<ColorAppBar>(context, listen: false);
    moviesProvider.getColorFromImg(movie.fullBackdropPath);

    return SliverAppBar(
      backgroundColor: moviesProvider.colorAppbar,
      floating: false,
      pinned: true,
      expandedHeight: size.height * 0.25,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: EdgeInsets.all(0),
        title: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          padding: EdgeInsets.only(
            bottom: size.height * 0.015,
            right: size.width * 0.05,
            left: size.width * 0.05,
          ),
          color: Colors.black45,
          child: Text(
            movie.title,
            style: TextStyle(fontSize: size.width * 0.06),
            textAlign: TextAlign.center,
          ),
        ),
        background: FadeInImage(
          placeholder: AssetImage('assets/gifs/loading.gif'),
          image: NetworkImage(movie.fullBackdropPath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _PosterAndTitle extends StatelessWidget {
  final Movie movie;

  const _PosterAndTitle({required this.movie});

  @override
  Widget build(BuildContext context) {
    final TextTheme theme = Theme.of(context).textTheme;

    final Size size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            child: FadeInImage(
              placeholder: AssetImage('assets/img/no-image.jpg'),
              image: NetworkImage(movie.fullPosterImg),
              height: size.height * 0.3,
              width: size.width * 0.4,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: size.width * 0.02),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ConstrainedBox(
                //   constraints: BoxConstraints(),
                //   child: Text(''),
                // ),
                Text(
                  movie.title,
                  style: theme.headline5,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                Text(
                  movie.originalTitle,
                  style: theme.subtitle2,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.star_outline,
                      size: size.height * 0.03,
                      color: Colors.grey,
                    ),
                    SizedBox(height: size.height * 0.05),
                    Text(
                      movie.voteAverage.toString(),
                      style: theme.caption,
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _OverView extends StatelessWidget {
  final String description;

  const _OverView({required this.description});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.05,
        vertical: size.height * 0.02,
      ),
      child: Text(
        description,
        textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.subtitle1,
      ),
    );
  }
}
