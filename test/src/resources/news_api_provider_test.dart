import 'package:news_flutter/src/resources/news_api_provider.dart';
import 'dart:convert';
import 'package:test/test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';


void main() {
  test('FetchTopIds return a list of ids', () async {
    final newsApi = NewsApiProvider();

    // MockClient, simula la conexión de htttp, para realizar pruebas.
    newsApi.client = MockClient((request) async {
      return Response(json.encode([1, 2, 3, 4]), 200);
    });

    final ids = await newsApi.fetchTopIds();

    expect(ids, [1, 2, 3, 4]);
  });

  test('FetchItem returns a item model', () async {
    final newsApi = NewsApiProvider();

    // MockClient, define que cualquier llamada hará un return de {'id': 123}
    newsApi.client = MockClient((request) async {
      final jsonMap = {'id': 123};
      return Response(json.encode(jsonMap), 200);
    });

    // Hace una llamada a la función enviando un valor, pero esperando un resultado definido en MockClient.
    final item = await newsApi.fetchItem(999);
    expect(item.id, 123);
  });
}
