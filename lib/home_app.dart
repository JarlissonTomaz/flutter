import 'package:flutter/material.dart';
import 'package:flutter_api/http/http_client.dart';
import 'package:flutter_api/repositories/produto_repository.dart';
import 'package:flutter_api/stores/produto_store.dart';

class HomApp extends StatefulWidget {
  const HomApp({super.key});

  @override
  State<HomApp> createState() => _HomAppState();
}

class _HomAppState extends State<HomApp> {
  final ProdutoStore store = ProdutoStore(
    repository: ProdutoRepository(
      client: HttpClient(),
    ),
  );

  @override
  void initState() {
    super.initState();
    store.getProsutos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('consumindo api'),
      ),
      body: AnimatedBuilder(
        animation: Listenable.merge([
          store.isLoading,
          store.state,
          store.erro,
        ]),
        builder: (context, child) {
          if (store.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (store.erro.value.isNotEmpty) {
            return Center(
              child: Text(
                store.erro.value,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
              ),
            );
          }

          if (store.state.value.isEmpty) {
            return const Center(
              child: Text(
                'Não tem nenhum item na Lista',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
              ),
            );
          } else {
            return ListView.separated(
              separatorBuilder: (context, index) {
                return const SizedBox(height: 32);
              },
              padding: const EdgeInsets.all(16),
              itemCount: store.state.value.length,
              itemBuilder: (_, index) {
                final item = store.state.value[index];

                return Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        item.thumbnail,
                        fit: BoxFit.cover,
                      ),
                    )
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }
}
