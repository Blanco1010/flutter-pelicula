import 'package:flutter/material.dart';

class CastingCards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(bottom: size.height * 0.05),
      width: double.infinity,
      height: 200,
      // color: Colors.red,
      child: ListView.builder(
        itemCount: 10,
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return _CastCard(size: size);
        },
      ),
    );
  }
}

class _CastCard extends StatelessWidget {
  const _CastCard({required this.size});

  final Size size;

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
              image: NetworkImage('https://via.placeholder.com/150x300'),
              fit: BoxFit.cover,
              height: size.height * 0.18,
              width: size.width * 0.27,
            ),
          ),
          SizedBox(height: size.height * 0.01),
          Text(
            'actor.name askadd sakdd',
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          )
        ],
      ),
    );
  }
}
