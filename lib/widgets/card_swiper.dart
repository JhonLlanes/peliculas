import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';

class CardSwiperScreen extends StatelessWidget {
  const CardSwiperScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // para traer el tamaño
    final size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height * 0.5,
      color: Colors.red,
      child: Swiper(
        layout: SwiperLayout.STACK,
        itemCount: 10,
        itemWidth: size.width * 0.6,
        itemHeight: size.height * 0.4,
        itemBuilder: (_, int index) {
          return GestureDetector(
            onTap: () =>
                Navigator.pushNamed(context, 'details', arguments: 'movie - '),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                  placeholder: AssetImage('assets/no-image.jpg'),
                  image: NetworkImage('https://placekitten.com/200/300'),
                  fit: BoxFit.cover),
            ),
          );
        },
      ),
    );
  }
}
