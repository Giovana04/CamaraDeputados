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
            onPressed: () {
              //colocar logica de usuario
            },
            icon: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 18,
              child: Icon(Icons.person, color: Colors.blueGrey),
            ),
          ),
          Padding(padding: EdgeInsetsGeometry.all(10)),
        ],
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                "Bem-vindo ao App da Câmara dos Deputados!",
                style: TextStyle(fontSize: 25, color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 20),

            Card(
              color: const Color.fromARGB(255, 68, 88, 97),
              margin: EdgeInsets.all(20),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      "Encontre informações sobre deputados federais.",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/buscaDeputados');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueGrey,
                        padding: EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 15,
                        ),
                        textStyle: TextStyle(fontSize: 18),
                      ),
                      child: Text(
                        "Buscar Deputados",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
