import 'package:flutter/material.dart';
import 'package:peliculas/widgets/widgets.dart';

class DetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String movie =
        ModalRoute.of(context)?.settings.arguments.toString() ?? 'no-moview';

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomAppBar(),
          SliverList(
              delegate: SliverChildListDelegate(
                  [_TitleAndDetalle(), _Overview(), CastingCards()]))
        ],
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.indigo,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: EdgeInsets.all(0),
        title: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          color: Colors.black12,
          child: Text(
            'movie',
            style: TextStyle(fontSize: 16),
          ),
        ),
        background: FadeInImage(
            placeholder: AssetImage('assets/no-image.jpg'),
            image: NetworkImage('https://placekitten.com/200/300'),
            fit: BoxFit.cover),
      ),
    );
  }
}

class _TitleAndDetalle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextTheme textTime = Theme.of(context).textTheme;

    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: AssetImage('assets/no-image.jpg'),
                image: NetworkImage('https://placekitten.com/200/300'),
                height: 150,
              )),
          SizedBox(width: 20),
          Column(
            children: [
              Text(
                "Movie Title",
                style: textTime.headline5,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                "Movie descripcion",
                style: textTime.subtitle1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                width: 5,
              ),
              Row(
                children: [
                  Icon(
                    Icons.star_outline,
                    size: 15,
                    color: Colors.red,
                  ),
                  Text(
                    'movies.voteAverange',
                    style: textTime.caption,
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

class _Overview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Text(
          'Sunt qui tempor sint aute cupidatat voluptate amet esse fugiat duis labore. Incididunt et nostrud enim aute. Cupidatat deserunt mollit enim do laboris aute. Fugiat mollit exercitation fugiat ut do fugiat minim aute esse. Officia nulla magna magna in. Officia minim cillum sint ad ut enim amet consequat eu aute. Nisi commodo aliquip dolor eu et excepteur exercitation nostrud incididunt laboris pariatur ipsum magna incididunt.',
          textAlign: TextAlign.justify,
          style: Theme.of(context).textTheme.subtitle1,
        ));
  }
}
