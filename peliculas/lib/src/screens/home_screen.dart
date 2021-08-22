import 'package:flutter/material.dart';
import 'package:peliculas/src/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Películas en cines'),
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search_off_outlined))
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            // CardSwpier
            CardSwiper(),

            //List of movies.
            SizedBox(height: size.height * 0.02),
            MovieSlider(),
          ],
        ),
      ),
    );
  }
}
