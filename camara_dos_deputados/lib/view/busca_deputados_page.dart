import 'package:camara_dos_deputados/service/camara_dos_deputados_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
  final ScrollController _scrollController = ScrollController();

  // detalhes do deputado
  List<dynamic>? _despesas;
  bool carregandoDetalhes = false;
  List<dynamic> _deputados = [];
  bool carrega = false;

  // controle de paginação
  int _paginaAtual = 1;
  bool _temMais = true;
  bool _carregandoMais = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          !_carregandoMais) {
        if (_temMais) {
          _carregandoMais = true;
          _paginaAtual++;
          _carregarMaisDeputados();
        }
      }
    });
  }

  Future<void> _buscaDeputados() async {
    FocusScope.of(context).unfocus(); // esconde o teclado

    setState(() {
      //como vai tudo começar
      carrega = true;
      _deputados = [];
      _paginaAtual = 1;
      _temMais = true;
    });

    try {
      final arq = await _camaraDosDeputadosService.getDeputados(
        nome: _nomeController.text,
        partido: _partidocontroller.text,
        estado: _estadoController.text,
        pagina: _paginaAtual,
      );

      setState(() {
        _deputados = arq["dados"];
        _temMais = arq["links"].any((link) => link["rel"] == "next");
      });
    } catch (e) {
      setState(() {
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 50, 60, 65),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            'Erro: ${e.toString()}',
            style: const TextStyle(color: Colors.redAccent, fontSize: 16),
          ),
        );
      });
    }

    setState(() {
      carrega = false;
    });
  }

  Future<void> _carregarMaisDeputados() async {
    setState(() {
      _carregandoMais = true;
    });

    try {
      final arq = await _camaraDosDeputadosService.getDeputados(
        nome: _nomeController.text,
        partido: _partidocontroller.text,
        estado: _estadoController.text,
        pagina: _paginaAtual++,
      );

      final novosDeputados = arq["dados"];
      setState(() {
        _deputados.addAll(novosDeputados);
        _temMais = arq["links"].any((link) => link["rel"] == "next");
        _carregandoMais = false;
        _paginaAtual++;
      });
    } catch (e) {
      setState(() {
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 50, 60, 65),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            'Erro: ${e.toString()}',
            style: const TextStyle(color: Colors.redAccent, fontSize: 16),
          ),
        );
        _carregandoMais = false;
      });
    }
  }

  Future<void> _buscaDetlhes(int id, bool expandido) async {
    setState(() {
      carregandoDetalhes = true;
      _despesas = null;
    });

    try {
      final despesas = await _camaraDosDeputadosService.getDespesas(id);

      setState(() {
        _despesas = despesas;
      });
    } catch (e) {
      setState(() {
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 50, 60, 65),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            'Erro: ${e.toString()}',
            style: const TextStyle(color: Colors.redAccent, fontSize: 16),
          ),
        );
      });
    }

    setState(() {
      carregandoDetalhes = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
        title: Image.asset(
          "assets/imgs/logo-brand-camara-mobile.png",
          height: 40,
        ),
      ),

      body: Padding(
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
            SizedBox(
              width: double.infinity,
              child: DropdownButtonFormField<String>(
                value: _estadoController.text.isEmpty ? null : _estadoController.text,
                decoration: const InputDecoration(labelText: 'Estado'),
                isExpanded: true,
                items: const [
                  DropdownMenuItem(value: '', child: Text('Selecione um estado')),
                  DropdownMenuItem(value: 'ac', child: Text('Acre')),
                  DropdownMenuItem(value: 'al', child: Text('Alagoas')),
                  DropdownMenuItem(value: 'ap', child: Text('Amapá')),
                  DropdownMenuItem(value: 'am', child: Text('Amazonas')),
                  DropdownMenuItem(value: 'ba', child: Text('Bahia')),
                  DropdownMenuItem(value: 'ce', child: Text('Ceará')),
                  DropdownMenuItem(value: 'df', child: Text('Distrito Federal')),
                  DropdownMenuItem(value: 'es', child: Text('Espírito Santo')),
                  DropdownMenuItem(value: 'go', child: Text('Goiás')),
                  DropdownMenuItem(value: 'ma', child: Text('Maranhão')),
                  DropdownMenuItem(value: 'mt', child: Text('Mato Grosso')),
                  DropdownMenuItem(value: 'ms', child: Text('Mato Grosso do Sul')),
                  DropdownMenuItem(value: 'mg', child: Text('Minas Gerais')),
                  DropdownMenuItem(value: 'pa', child: Text('Pará')),
                  DropdownMenuItem(value: 'pb', child: Text('Paraíba')),
                  DropdownMenuItem(value: 'pr', child: Text('Paraná')),
                  DropdownMenuItem(value: 'pe', child: Text('Pernambuco')),
                  DropdownMenuItem(value: 'pi', child: Text('Piauí')),
                  DropdownMenuItem(value: 'rj', child: Text('Rio de Janeiro')),
                  DropdownMenuItem(value: 'rn', child: Text('Rio Grande do Norte')),
                  DropdownMenuItem(value: 'rs', child: Text('Rio Grande do Sul')),
                  DropdownMenuItem(value: 'ro', child: Text('Rondônia')),
                  DropdownMenuItem(value: 'rr', child: Text('Roraima')),
                  DropdownMenuItem(value: 'sc', child: Text('Santa Catarina')),
                  DropdownMenuItem(value: 'sp', child: Text('São Paulo')),
                  DropdownMenuItem(value: 'se', child: Text('Sergipe')),
                  DropdownMenuItem(value: 'to', child: Text('Tocantins')),
                ],
                onChanged: (value) {
                  setState(() {
                    _estadoController.text = value ?? '';
                  });
                },
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: _buscaDeputados, child: Text("Buscar")),
            SizedBox(height: 20),

            if (carrega)
              CircularProgressIndicator()
            else if (_deputados.isEmpty)
              Text("Nenhum deputado encontrado.")
            else
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: _deputados.length + (_temMais ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index >= _deputados.length) {
                      // Se ainda tiver páginas para carregar, mostra o indicador senão, mostre um espaço vazio.
                      return _temMais
                          ? const Center(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: CircularProgressIndicator(),
                              ),
                            )
                          : const SizedBox.shrink();
                    }

                    final deputado = _deputados[index];
                    final deputadoId = deputado["id"] as int;

                    return Card(
                      child: ExpansionTile(
                        onExpansionChanged: (expandido) {
                          _buscaDetlhes(deputadoId, expandido);
                        },
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(deputado["urlFoto"]),
                        ),
                        title: Text(deputado["nome"]),
                        subtitle: Text(
                          "${deputado["siglaPartido"]} - ${deputado["siglaUf"]}",
                        ),
                        children: <Widget>[_exibeDetalhesDeputado()],
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _exibeDetalhesDeputado() {
    if (_deputados.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text("Não foi possível carregar os detalhes."),
      );
    }

    final despesaMaisRecente = _despesas != null && _despesas!.isNotEmpty
        ? _despesas!
              .first // se as despesas não forem vazias pega a primeira
        : null;
    final totalDespesasRecentes =
        _despesas?.fold<double>(
          // fold faz a soma de um campo especifico
          0.0,
          (sum, item) => sum + (item['valorLiquido'] as num).toDouble(),
        ) ??
        0.0;

    final currencyFormatter = NumberFormat.currency(
      // formata o valor para real
      locale: 'pt_BR',
      symbol: 'R\$',
    );

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Despesas Recentes",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          SizedBox(height: 12),
          Text(
            "Soma de despesas:",
            style: TextStyle(color: Color.fromARGB(255, 148, 143, 143)),
          ),
          Text(
            currencyFormatter.format(totalDespesasRecentes),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Divider(height: 24, thickness: 1), // é um linha
          Text(
            "Gasto mais recente:",
            style: TextStyle(color: Color.fromARGB(255, 148, 143, 143)),
          ),
          if (despesaMaisRecente != null)
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(despesaMaisRecente['tipoDespesa']),
              subtitle: Text("Data: ${despesaMaisRecente['dataDocumento']}"),
              trailing: Text(
                currencyFormatter.format(despesaMaisRecente['valorLiquido']),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            )
          else
            Text("Nenhuma despesa encontrada no período."),
        ],
      ),
    );
  }
}
