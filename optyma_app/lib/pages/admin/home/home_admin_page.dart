import 'package:flutter/material.dart';
import 'package:optyma_app/widgets/menu_admin.dart';


class HomeAdminPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin'),
      ),
      drawer: MenuAdmin(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Center(child: Text('Bienvenido admin!'),)
        ],
      ),
    );
  }
}