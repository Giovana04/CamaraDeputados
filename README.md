# Câmara dos Deputados

Aplicativo Flutter para consultar deputados federais e seus gastos, consumindo a [API de Dados Abertos da Câmara](https://dadosabertos.camara.leg.br/swagger/api.html).

![Flutter](https://img.shields.io/badge/Flutter-02569B?logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?logo=dart&logoColor=white)
![REST API](https://img.shields.io/badge/API-REST-informational)

## O que o app faz

- **Busca de deputados** por nome, partido (sigla) e estado (UF), combinados ou isolados.
- **Rolagem infinita:** carrega 15 deputados por página e busca a próxima automaticamente ao chegar ao fim da lista.
- **Cartão expansível por deputado:** ao abrir, o app busca as despesas dele.
- **Despesas:** percorre todas as páginas de despesas da cota parlamentar, soma o valor líquido e mostra o lançamento mais recente, com valores em reais.

## Como a integração com a API funciona

O acesso à API fica isolado em uma classe de serviço (`lib/service/camara_dos_deputados_service.dart`), separada das telas:

| Método | Endpoint | Observação |
|---|---|---|
| `getDeputados` | `GET /deputados` | filtros `nome`, `siglaPartido`, `siglaUf`, paginação com 15 itens |
| `getDeputadoDetalhes` | `GET /deputados/{id}` | lê o campo `dados` da resposta (já implementado no serviço, ainda não usado nas telas) |
| `getDespesas` | `GET /deputados/{id}/despesas` | pagina de 100 em 100 até não existir o link `next` e para em 1000 páginas por segurança |

As respostas JSON são decodificadas com o pacote `http`, e respostas com status diferente de 200 viram exceções.

## Estrutura

```
camara_dos_deputados/lib/
├── main.dart                         tema e rotas
├── service/
│   └── camara_dos_deputados_service.dart   chamadas à API
└── view/
    ├── home_page.dart                tela inicial
    └── busca_deputados_page.dart     busca, lista paginada, detalhes e despesas
```

## Como executar

Requer Flutter com Dart `^3.8.1`.

```bash
git clone https://github.com/Giovana04/CamaraDeputados.git
cd CamaraDeputados/camara_dos_deputados

flutter pub get
flutter run
```

A API é pública e não exige chave de acesso.

## Próximos passos

- Favoritar deputados e guardar a lista no aparelho.
- Exibir mensagens de erro na tela de busca, que hoje captura a exceção sem mostrá-la.
- Gráfico de despesas por tipo e por mês.
- Testes para a camada de serviço.
