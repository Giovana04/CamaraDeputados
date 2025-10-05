import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Padding(
          padding: EdgeInsetsGeometry.only(left: 5),
          child: Image.asset("assets/imgs/logo-brand-camara-mobile.png"),
        ),

        actions: [
          IconButton(
            onPressed: () {},
            icon: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 18,
              child: Icon(Icons.person, color: Colors.blueGrey),
            ),
          ),
          Padding(padding: EdgeInsetsGeometry.all(10)),
        ],
      ),
    );
  }
}
