import 'package:camara_dos_deputados/service/camara_dos_deputados_service.dart';
import 'package:flutter/material.dart';

class BuscaDeputadosPage extends StatefulWidget {
  const BuscaDeputadosPage({super.key});

  @override
  State<BuscaDeputadosPage> createState() => _BuscaDeputadosPageState();
}

class _BuscaDeputadosPageState extends State<BuscaDeputadosPage> {
  final _nomeController = TextEditingController();
  final _partidocontroller = TextEditingController();
  final _estadoController = TextEditingController();

  final _camaraDosDeputadosService = CamaraDosDeputadosService();

  List<dynamic> _deputados = [];
  bool carrega = false;

  @override
  void initState() {
    super.initState();
  }
  
  Future<void> _buscaDeputdo() async{
    setState(() {
      carrega = true;
      _deputados = [];
    });

    try{
      final arq = await _camaraDosDeputadosService.getDeputados(
        nome: _nomeController.text,
        partido: _partidocontroller.text,
        estado: _estadoController.text,
      );

      setState(() {
        _deputados = arq["dados"];
        if (_deputados.isEmpty) {
          Container(

          );
        }
      });
    } catch(e){
      setState(() {
        Container(
          //vai mostrar o erro que veio (e.toString)
        );
      });
    }

    setState(() {
      carrega = false;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}