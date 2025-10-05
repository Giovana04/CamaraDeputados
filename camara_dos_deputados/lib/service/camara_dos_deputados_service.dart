import 'package:http/http.dart' as http;
import 'dart:convert';

class CamaraDosDeputadosService {
  final String _baseUrl = "https://dadosabertos.camara.leg.br/api/v2";

  Future<Map<String, dynamic>> getDeputados({
    String? nome,
    String? partido,
    String? estado,
    int pagina = 1,
  }) async{

    final Map<String, String> queryParameters = {
      'pagina': pagina.toString(),
      'itens': '15',
    };

    if (nome != null && nome.isNotEmpty) {
      queryParameters['nome'] = nome;
    }
    if (partido != null && partido.isNotEmpty) {
      queryParameters['siglaPartido'] = partido;
    }
    if (estado != null && estado.isNotEmpty) {
      queryParameters['siglaUf'] = estado;
    }

    final uri = Uri.https('dadosabertos.camara.leg.br', '/api/v2/deputados', queryParameters);
    print("chamou a url: $uri");

    final response = await http.get(uri);
    if (response.statusCode == 200) {
      print(response.body);
      return json.decode(response.body);
    }
    else{
      throw Exception("Erro ao Get deputados: ${response.statusCode}");
    }
  }

  Future<Map<String, dynamic>> getDeputadoDetalhes(int id) async {
    final response = await http.get(Uri.parse('$_baseUrl/deputados/$id'));
    if (response.statusCode == 200) {
      return json.decode(response.body)['dados'];
    } else {
      throw Exception('Falha ao carregar detalhes do deputado.');
    }
  }

  Future<List<dynamic>> getDespesas(int id) async {
    // Adicionamos ordenação para pegar as despesas mais recentes
    final response = await http.get(Uri.parse('$_baseUrl/deputados/$id/despesas?ordem=DESC&ordenarPor=dataDocumento'));
    if (response.statusCode == 200) {
      return json.decode(response.body)['dados'];
    } else {
      throw Exception('Falha ao carregar despesas.');
    }
  }


}


