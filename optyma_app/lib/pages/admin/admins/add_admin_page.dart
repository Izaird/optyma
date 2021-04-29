import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optyma_app/bloc/notAdmins/not_admins_bloc.dart';
import 'package:optyma_app/pages/admin/admins/not_admins_list.dart';
import 'package:optyma_app/repository/authentication_repository.dart';
import 'package:optyma_app/repository/users_repository.dart';

class AddAdminPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotAdminsBloc(
        usersRepository: RepositoryProvider.of<UsersRepository>(context),
        authenticationRepository: RepositoryProvider.of<AuthenticationRepository>(context))
        ..add(NotAdminsLoaded()),

      child: Scaffold(
        appBar: AppBar(
          title: Text('Agregar administrador'),
        ),
        body: NotAdminsList(),
      )
    );
  }
}