import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pelicula/src/models/credits_responde.dart';
import 'package:pelicula/src/providers/movies_provider.dart';

class CastingCards extends StatelessWidget {
  final int movieId;

  const CastingCards({required this.movieId});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);

    return FutureBuilder(
      future: moviesProvider.getMoviesCast(movieId),
      builder: (BuildContext context, AsyncSnapshot<List<Cast>> snapshot) {
        if (!snapshot.hasData) {
          return Container(
            constraints: BoxConstraints(maxWidth: 150),
            height: 200,
            child: CupertinoActivityIndicator(),
          );
        }

        final cast = snapshot.data!;

        return Container(
          margin: EdgeInsets.only(bottom: size.height * 0.05),
          width: double.infinity,
          height: 200,
          // color: Colors.red,
          child: ListView.builder(
            itemCount: cast.length,
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, int index) => _CastCard(
              size: size,
              name: cast[index].name,
              profilePath: cast[index].fullProfilePath,
            ),
          ),
        );
      },
    );
  }
}

class _CastCard extends StatelessWidget {
  const _CastCard(
      {required this.size, required this.name, required this.profilePath});

  final Size size;
  final String name;
  final String profilePath;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.2,
      width: size.width * 0.3,
      // color: Colors.black,
      margin: EdgeInsets.symmetric(horizontal: size.height * 0.01),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            child: FadeInImage(
              placeholder: AssetImage('assets/gifs/loading.gif'),
              image: NetworkImage(profilePath),
              // image: NetworkImage('https://via.placeholder.com/150x300'),
              fit: BoxFit.cover,
              height: size.height * 0.18,
              width: size.width * 0.27,
            ),
          ),
          SizedBox(height: size.height * 0.01),
          Text(
            name,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          )
        ],
      ),
    );
  }
}
