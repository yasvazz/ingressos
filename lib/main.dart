import 'package:flutter/material.dart';
import 'telas/ingresso_screen.dart';

void main() {
  runApp(const IngressosApp());
}

class IngressosApp extends StatelessWidget {
  const IngressosApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ingressos para o Jogo',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      home: const IngressoScreen(),
    );
  }
}