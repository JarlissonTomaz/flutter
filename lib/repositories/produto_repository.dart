import 'package:flutter_api/models/produto_model.dart';

abstract class IProdutoRepository {
  Future<List<ProdutoModel>> getProdutos();
}

class ProdutoRepository implements IProdutoRepository {
  @override
  Future<List<ProdutoModel>> getProdutos() {
    // TODO: implement getProdutos
    throw UnimplementedError();
  }
}
