import 'package:flutter/material.dart';
import 'package:optyma_app/presentation/core/player_navigation_menu.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pagina principal'),
      ),
      drawer: PlayerNavigationMenu(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children:[
          Center(
            child: Text('Bienvenido usuario!')
          )
        ],
      ),
    );
  }
}