import 'package:flutter/material.dart';

class HomApp extends StatefulWidget {
  const HomApp({super.key});

  @override
  State<HomApp> createState() => _HomAppState();
}

class _HomAppState extends State<HomApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('api request'),
      ),
    );
  }
}
