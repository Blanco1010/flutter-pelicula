import 'package:flutter/material.dart';
import 'package:peliculas/src/models/movie.dart';
import 'package:peliculas/src/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class MovieSlider extends StatefulWidget {
  final List<Movie> movies;
  final String title;
  final Function onNextPage;

  const MovieSlider({
    required this.movies,
    required this.title,
    required this.onNextPage,
  });

  @override
  _MovieSliderState createState() => _MovieSliderState();
}

class _MovieSliderState extends State<MovieSlider> {
  final ScrollController scrollController = new ScrollController();
  bool _getMorePopular = true;
  @override
  void initState() {
    super.initState();

    scrollController.addListener(() async {
      final double diff = scrollController.position.pixels -
          scrollController.position.maxScrollExtent;

      if (diff >= 0 && diff <= 5) {
        if (_getMorePopular) {
          print('Next to page');
          _getMorePopular = false;
          widget.onNextPage();
        } else {
          await Future.delayed(Duration(seconds: 1));
          _getMorePopular = true;
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    if (widget.movies.length == 0) {
      return Container(
        width: double.infinity,
        height: size.height * 0.5,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Container(
      width: double.infinity,
      height: size.height * 0.37,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
            child: Text(
              this.widget.title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Flexible(
            child: ListView.builder(
              controller: scrollController,
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: widget.movies.length,
              itemBuilder: (BuildContext context, int index) {
                return _MoviePoster(
                  movie: widget.movies[index],
                  heroId: '${widget.title}-${index}-${widget.movies[index].id}',
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _MoviePoster extends StatelessWidget {
  final Movie movie;
  final String heroId;

  const _MoviePoster({required this.movie, required this.heroId});

  @override
  Widget build(BuildContext context) {
    movie.heroId = heroId;
    final size = MediaQuery.of(context).size;
    return Container(
      width: 130,
      height: 190,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        children: [
          GestureDetector(
            onTap: () async {
              final moviesProvider =
                  Provider.of<ColorAppBar>(context, listen: false);
              await moviesProvider.getColorFromImg(movie.fullBackdropPath);
              Navigator.pushNamed(context, 'details', arguments: movie);
            },
            child: Hero(
              tag: movie.heroId!,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: FadeInImage(
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  image: NetworkImage(movie.fullPosterImg),
                  height: size.height * 0.20,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(height: size.height * 0.01),
          Text(
            movie.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
