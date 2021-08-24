import 'package:flutter/material.dart';
import 'package:peliculas/src/models/movie.dart';

class MovieSlider extends StatelessWidget {
  final List<Movie> movies;
  final String title;

  const MovieSlider({required this.movies, required this.title});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    if (movies.length == 0) {
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
              this.title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Flexible(
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: movies.length,
              itemBuilder: (BuildContext context, int index) {
                final String _url = movies[index].fullPosterImg;
                final String _title = movies[index].title;

                return _MoviePoster(
                  title: _title,
                  url: _url,
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
  final String title;
  final String url;

  const _MoviePoster({required this.title, required this.url});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: 130,
      height: 190,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, 'details',
                  arguments: 'movie-instance');
            },
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: FadeInImage(
                placeholder: AssetImage('assets/img/no-image.jpg'),
                image: NetworkImage(url),
                height: size.height * 0.25,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: size.height * 0.01),
          Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
