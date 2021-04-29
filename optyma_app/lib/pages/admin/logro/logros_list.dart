import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optyma_app/bloc/logros/logros_bloc.dart';
import 'package:optyma_app/models/logro_model.dart';
import 'package:optyma_app/repository/cloud_firestore_repository.dart';

class LogrosList extends StatefulWidget {

  @override
  _LogrosListState createState() => _LogrosListState();
}

class _LogrosListState extends State<LogrosList> {

  List<LogroModel> logrosList = [];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LogrosBloc, LogrosState>(
      builder: (context, state){
        if(state is LogrosLoadInProgress){
          return Center(child: CircularProgressIndicator(),);
        }
        if(state is LogrosLoadFailure){
          return Center( 
            child: Column(  
              children: [
                Icon(Icons.error),
                Text('Hubo un error al cargar la información')
              ],
            ),
          );
        }
        if(state is LogrosLoadSuccess){
          logrosList = state.logros;
          return Container(
            child: logrosList.length == 0
            ? Center(child: Text('Logros no disponibles'),)
            : ListView.builder(
              itemCount: logrosList.length,
              itemBuilder: (context, i){
                return _createItem(context, logrosList[i]);
                

              },
            ),
          );
        }
      },
    );
  }

  Widget _createItem(BuildContext context, LogroModel logro){
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.red,
      ),
      onDismissed: (direction) {
        RepositoryProvider.of<CloudFirestoreRepository>(context).deleteLogro(logro.id);
      },
      child: ListTile(
        title: Text('${logro.name}'),
        subtitle: Text('${logro.description}'),
        onTap: () => Navigator.pushNamed(context, 'addLogro', arguments: logro),
      ),
    );
  }
}