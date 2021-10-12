import 'package:flutter/material.dart';
import 'package:optyma_app/presentation/home/admin/widgets/admin_navigation_menu.dart';


class HomeAdmin extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Pagina principal'),
        ),
        drawer: AdminNavigationMenu(),
          body: Center(
              child: Text('HomeAdminPage'),
          ),
      );
    }
}