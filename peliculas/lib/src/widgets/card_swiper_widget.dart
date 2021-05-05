import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:peliculas/src/models/peliculas_model.dart';

class CardSwiper extends StatelessWidget {
  final List<Pelicula> peliculas;

  CardSwiper({required this.peliculas});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    // peliculas![index].uniqueId = '${peliculas![index].id}-tarjeta';

    //() => Navigator.pushNamed(context, 'detalle',arguments: peliculas![index]),
    return CarouselSlider.builder(
        itemCount: this.peliculas.length,
        itemBuilder: (context, index, realIndex) =>
            FadePosterImage(pelicula: peliculas[index]),
        options: CarouselOptions(
            autoPlay: true, aspectRatio: 2.0, enlargeCenterPage: true));
  }
}

class FadePosterImage extends StatelessWidget {
  const FadePosterImage({
    Key? key,
    required this.pelicula,
  }) : super(key: key);

  final pelicula;

  @override
  Widget build(BuildContext context) {
    return FadeInImage(
      placeholder: AssetImage('assets/img/no-image.jpg'),
      image: NetworkImage(pelicula.getPosterImg()),
      fit: BoxFit.cover,
    );
  }
}
