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

  Future<void> _buscaDeputados() async {
    setState(() {
      carrega = true;
      _deputados = [];
    });

    try {
      final arq = await _camaraDosDeputadosService.getDeputados(
        nome: _nomeController.text,
        partido: _partidocontroller.text,
        estado: _estadoController.text,
      );

      setState(() {
        _deputados = arq["dados"];
        if (_deputados.isEmpty) {
          Container();
        }
      });
    } catch (e) {
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center, // pq não centralizou?????
          children: [Image.asset("assets/imgs/logo-brand-camara-mobile.png")],
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _nomeController,
                decoration: InputDecoration(labelText: "Nome do Deputado"),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _partidocontroller,
                decoration: InputDecoration(labelText: "Partido"),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _estadoController,
                decoration: InputDecoration(labelText: "Estado"),
              ),
              SizedBox(height: 20),
              ElevatedButton(onPressed: _buscaDeputados, child: Text("Buscar")),
              SizedBox(height: 20),
              if (carrega)
                CircularProgressIndicator()
              else if (_deputados.isEmpty)
                Text("Nenhum deputado encontrado.")
              else
                ListView.builder(
                  shrinkWrap:
                      true, // faz a ListView ocupar apenas o espaço necessário
                  physics:
                      NeverScrollableScrollPhysics(), // desabilita o scroll da ListView para evitar conflitos com o SingleChildScrollView
                  itemCount: _deputados.length,
                  itemBuilder: (context, index) {
                    final deputado = _deputados[index];
                    return Card(
                      child: ListTile(
                        title: Text(deputado["nome"]),
                        subtitle: Text(
                          "${deputado["siglaPartido"]} - ${deputado["siglaUf"]}",
                        ),
                        onTap: () {},
                      ),
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
