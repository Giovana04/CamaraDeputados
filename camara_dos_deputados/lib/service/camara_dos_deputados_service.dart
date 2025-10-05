import 'package:http/http.dart' as http;
import 'dart:convert';

class CamaraDosDeputadosService {
  Future<Map<String, dynamic>> getDeputados({
    String? nome,
    String? partido,
    String? estado,
  }) async{

    final Map<String, String> queryParameters = {};

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
      return json.decode(response.body);
    }
    else{
      throw Exception("Erro ao Get deputados: ${response.statusCode}");
    }
  }
}


