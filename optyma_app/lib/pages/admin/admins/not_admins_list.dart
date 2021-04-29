import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:optyma_app/bloc/notAdmins/not_admins_bloc.dart';
import 'package:optyma_app/models/user_model.dart';
import 'package:optyma_app/repository/users_repository.dart';

class NotAdminsList extends StatefulWidget {

  @override
  _NotAdminsListState createState() => _NotAdminsListState();
}

class _NotAdminsListState extends State<NotAdminsList> {

  List<UserModel> notAdminsList = [];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotAdminsBloc, NotAdminsState>(
      builder: (context, state){
        if(state is NotAdminsLoadInProgress){
          return Center(child: CircularProgressIndicator(),);
        }
        if(state is NotAdminsLoadFailure){
          return Center( 
            child: Column(  
              children: [
                Icon(Icons.error),
                Text('Hubo un error al cargar la información')
              ],
            ),
          );
        }
        if(state is NotAdminsLoadSuccess){
          notAdminsList = state.notAdmins;
          return Container(
            child: notAdminsList.length == 0
            ? Center(child: Text('Usuarios no disponibles'),)
            : ListView.builder(
              itemCount: notAdminsList.length,
              itemBuilder: (context, i){
                return _createItem(context, notAdminsList[i]);

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
        RepositoryProvider.of<UsersRepository>(context).updateUserAdminStatus(admin: true, userId: admin.uid);
      },
      child: ListTile(
        title: Text('${admin.name}'),
        subtitle: Text('${admin.email}'),
        onTap: () => Navigator.pushNamed(context, 'addPlantilla', arguments: admin),
      ),
    );
  }
}