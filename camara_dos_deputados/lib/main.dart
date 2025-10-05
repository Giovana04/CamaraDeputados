import 'package:camara_dos_deputados/view/busca_deputados_page.dart';
import 'package:camara_dos_deputados/view/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: Color.fromARGB(255, 34, 50, 63),
    ),
    initialRoute: "/",
    routes: {
      "/buscaDeputados": (context) => const BuscaDeputadosPage(),
      "/": (context) => const HomePage(),
    },
  ));
}