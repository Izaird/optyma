import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optyma_app/bloc/admins/admins_bloc.dart';
import 'package:optyma_app/pages/admin/admins/admins_list.dart';
import 'package:optyma_app/repository/authentication_repository.dart';
import 'package:optyma_app/repository/users_repository.dart';



class AdminsPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AdminsBloc(
        usersRepository: RepositoryProvider.of<UsersRepository>(context),
        authenticationRepository: RepositoryProvider.of<AuthenticationRepository>(context))
        ..add(AdminsLoaded()),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Administradores'),
        ),
        body: AdminsList(),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: (){
            Navigator.pushNamed(context, 'addAdmin');
          },
        )
      ),
    );
  }
}