import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:optyma_app/bloc/admins/admins_bloc.dart';
import 'package:optyma_app/models/user_model.dart';
import 'package:optyma_app/repository/users_repository.dart';

class AdminsList extends StatefulWidget {

  @override
  _AdminsListState createState() => _AdminsListState();
}

class _AdminsListState extends State<AdminsList> {

  List<UserModel> adminsList = [];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminsBloc, AdminsState>(
      builder: (context, state){
        if(state is AdminsLoadInProgress){
          return Center(child: CircularProgressIndicator(),);
        }
        if(state is AdminsLoadFailure){
          return Center( 
            child: Column(  
              children: [
                Icon(Icons.error),
                Text('Hubo un error al cargar la información')
              ],
            ),
          );
        }
        if(state is AdminsLoadSuccess){
          adminsList = state.admins;
          return Container(
            child: adminsList.length == 0
            ? Center(child: Text('No hay mas administradores'),)
            : ListView.builder(
              itemCount: adminsList.length,
              itemBuilder: (context, i){
                return _createItem(context, adminsList[i]);

              },
            ),
          );
        }
        return Container();
      },
    );
  }

  Widget _createItem(BuildContext context, UserModel admin){

    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.red,
      ),
      onDismissed: (direction) {
        RepositoryProvider.of<UsersRepository>(context).updateUserAdminStatus(admin: false, userId: admin.uid);
      },
      child: ListTile(
        title: Text('${admin.name}'),
        subtitle: Text('${admin.email}'),
        onTap: () => Navigator.pushNamed(context, 'addPlantilla', arguments: admin),
      ),
    );
  }
}