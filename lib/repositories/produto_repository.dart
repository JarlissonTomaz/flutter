import 'dart:convert';
import 'package:flutter_api/http/http_client.dart';
import 'package:flutter_api/models/produto_model.dart';

abstract class IProdutoReposity {
  Future<List<ProdutoModel>> getProdutos();
}

class ProdutoRepository implements IProdutoReposity {
  ProdutoRepository({required this.client});

  final IHttpClient client;

  @override
  Future<List<ProdutoModel>> getProdutos() async {
    final response = await client.get(
      url: 'https://dummyjson.com/products',
    );

    if (response.statusCode == 200) {
      final List<ProdutoModel> produtos = [];

      final body = jsonDecode(response.body);

      body['products'].map(
        (item) {
          final ProdutoModel produto = ProdutoModel.fromMap(item);
          produtos.add(produto);
        },
      ).toList();

      return produtos;
    } else if (response.statusCode == 404) {
      throw ('A Url informada não é válidas');
    } else {
      throw Exception('Não foi possivel carregar os produtos');
    }
  }
}
