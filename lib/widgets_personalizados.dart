import 'package:flutter/material.dart';


/*  Painel personalizado (Icone
*   e descricao customizaveis). */
class CustomPainel extends StatelessWidget {
  const CustomPainel({super.key, required this.icone, required this.descricao});

  final IconData icone;   // Icone do painel.
  final String descricao; // Descricao do painel.
  static const RoundedRectangleBorder shapeborda = RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.0)));

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 3,
      child: Card(
        color: Colors.blueGrey,
        shape: shapeborda,    // Borda.
        child: Card(
          color: Colors.black38,
          margin: const EdgeInsets.all(10),
          shape:  shapeborda, // Borda.
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icone, size: 50, color: Colors.redAccent), // Icone.
              Text(descricao, style: const TextStyle(color: Colors.lightGreenAccent, fontWeight: FontWeight.bold)), // Descricao.
            ],
          ),
        ),
      ),
    );
  }
}