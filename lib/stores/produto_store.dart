import 'package:flutter/material.dart';
import 'package:flutter_api/http/exceptions.dart';
import 'package:flutter_api/models/produto_model.dart';
import 'package:flutter_api/repositories/produto_repository.dart';

class ProdutoStore {
  final IProdutoRepository repository;
  ProdutoStore({required this.repository});

  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  final ValueNotifier<List<ProdutoModel>> state =
      ValueNotifier<List<ProdutoModel>>([]);

  final ValueNotifier<String> erro = ValueNotifier<String>('');

  Future getProsutos() async {
    isLoading.value = true;

    try {
      final result = await repository.getProdutos();
      state.value = result;
    } on NotFoundExecption catch (e) {
      erro.value = e.message;
    } catch (e) {
      erro.value = e.toString();
    }

    isLoading.value = true;
  }
}
