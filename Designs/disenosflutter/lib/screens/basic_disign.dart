import 'package:flutter/material.dart';

class BasicDesignScreen extends StatelessWidget {
  BasicDesignScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Image(image: AssetImage('assets/landscape.jpg')),
          Title(),
          ButtonSeccion(),

          // texto
          Container(
            margin: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
            child: Text(
                'Consequat  magna dolore aliqua quis. Lorem est laboris veniam dolore cupidatat commodo esse aliquip mollit aliqua. Duis anim est aliquip Lorem do ex ullamco pariatur dolor ut mollit eu. Cillum quis commodo amet do est duis qui nisi esse esse duis in incididunt. Dolore deserunt eu nostrud voluptate deserunt dolor sit deserunt ad irure pariatur nostrud velit. Mollit excepteur occaecat sint ad enim tempor aliquip commodo voluptate culpa ex ut dolore. Eu veniam anim aliquip ex irure velit elit eu esse aliquip excepteur exercitation proident. Duis esse irure elit id ad dolore culpa deserunt amet elit. Amet eu incididunt anim officia. Lorem mollit ad elit magna nostrud. Adipisicing non in occaecat ad laborum culpa ad.',
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                )),
          ),
        ],
      ),
    );
  }
}

class ButtonSeccion extends StatelessWidget {
  const ButtonSeccion({Key? key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        CustomButton(icon: Icons.call, titulo: 'Call'),
        CustomButton(icon: Icons.map, titulo: 'Map'),
        CustomButton(icon: Icons.share, titulo: 'Share'),
      ]),
    );
  }
}

class CustomButton extends StatelessWidget {
  final IconData icon;
  final String titulo;

  const CustomButton({
    super.key,
    required this.icon,
    required this.titulo,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          size: 40,
        ),
        Text(titulo)
      ],
    );
  }
}

class Title extends StatelessWidget {
  const Title({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            'nombre titiulo ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text('detalle titulo ---> '),
        ]),
        Expanded(child: Container()),
        Icon(Icons.star, color: Colors.red),
        Text('41')
      ]),
    );
  }
}
