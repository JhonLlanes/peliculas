import 'package:flutter/material.dart';
import 'package:peliculas/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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

          CardSwiperScreen(),
          MovieSlider(),

          // listado horizontal
        ]),
      ),
    );
  }
}
