import 'package:flutter/material.dart';
import 'package:peliculas/providers/movies_provider.dart';
import 'package:peliculas/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final moviesProviders = Provider.of<MoviesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Peliculas en cines'),
        elevation: 0,
        actions: [
          IconButton(icon: Icon(Icons.search), onPressed: () => {})
        ], // Puedes personalizar el texto según tu preferencia
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          // TODO cardSwipper

          CardSwiperScreen(movies: moviesProviders.onDisplayMovies),
          MovieSlider(
            movies: moviesProviders.onDisplayPopularMovies,
            titulo: 'Populares',
            onNextPage: () => moviesProviders.getDisplayPopularMovies(),
          ),

          // listado horizontal
        ]),
      ),
    );
  }
}
