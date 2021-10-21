import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:optyma_app/domain/users/user.dart';


class UserFormPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final editedUser = ModalRoute.of(context)!.settings.arguments as User;


    return Scaffold(
      appBar: AppBar(  
        title: const Text('Editando usuario'),
        actions: [
          IconButton(
            onPressed: () {
            }, 
            icon: const Icon(FontAwesomeIcons.check)
          )
        ],
        leading: IconButton(
          icon: const Icon(FontAwesomeIcons.times),
          onPressed: () => Navigator.pop(context),
        ),
      ),
    );

  }
}