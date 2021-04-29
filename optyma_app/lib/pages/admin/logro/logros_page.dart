import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optyma_app/bloc/logros/logros_bloc.dart';
import 'package:optyma_app/pages/admin/logro/logros_list.dart';
import 'package:optyma_app/repository/cloud_firestore_repository.dart';


class LogrosPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LogrosBloc(
        cloudFirestoreRepository: RepositoryProvider.of<CloudFirestoreRepository>(context))
        ..add(LogrosLoaded()),

      child:Scaffold(
        appBar: AppBar(
          title: Text('Logros'),
        ), 
        body: LogrosList(),
        floatingActionButton: FloatingActionButton(  
          child: Icon(Icons.add),
          onPressed: (){
            Navigator.pushNamed(context, 'addLogro');
          },
        ),
      )
    );
    
  }

}
