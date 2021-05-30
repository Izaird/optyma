import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optyma_app/bloc/logros_list/logros_list_bloc.dart';
import 'package:optyma_app/models/logro_model.dart';
import 'package:optyma_app/repository/logros_repository.dart';

class LogrosListPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de logros'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocProvider(
          create: (context) => LogrosListBloc(
            logrosRepository: RepositoryProvider.of<LogrosRepository>(context)),
          child: LogrosListBody(), 
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.pushNamed(context, 'addLogro');
        },
      ),
    );
    
  }

}

class LogrosListBody extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MenuTypesOfLogros(),
        LogrosListBlocBuilder(),
      ],
    );
  }
}


class MenuTypesOfLogros extends StatefulWidget{
  @override
  _MenuTypesOfLogrosState createState() => _MenuTypesOfLogrosState();
}

class _MenuTypesOfLogrosState extends State<MenuTypesOfLogros> {
  String _typeOfLogro ;
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      hint: Text('Tipos de logro'), 
      value: _typeOfLogro,
      items: <DropdownMenuItem>[
        DropdownMenuItem(
          value: 'Niveles',
          child: Text('Niveles'),
          onTap: () {
            BlocProvider.of<LogrosListBloc>(context).add(LogrosListType1Selected());
            BlocProvider.of<LogrosListBloc>(context).add(LogrosListLoaded());
          },
        ),
        DropdownMenuItem(
          value: 'Racha de respuestas',
          child: Text('Racha de respuestas'),
          onTap: () {
            BlocProvider.of<LogrosListBloc>(context).add(LogrosListType2Selected());
            BlocProvider.of<LogrosListBloc>(context).add(LogrosListLoaded());
          },
        ),
        DropdownMenuItem(
          value: 'Racha de días',
          child: Text('Racha de días'),
          onTap: () {
            BlocProvider.of<LogrosListBloc>(context).add(LogrosListType3Selected());
            BlocProvider.of<LogrosListBloc>(context).add(LogrosListLoaded());
          },
        ),
        DropdownMenuItem(
          value: 'Ejercicios realizados',
          child: Text('Ejercicios realizados'),
          onTap: () {
            BlocProvider.of<LogrosListBloc>(context).add(LogrosListType4Selected());
            BlocProvider.of<LogrosListBloc>(context).add(LogrosListLoaded());
          },
        ),
        DropdownMenuItem(
          value: 'Leaderboard',
          child: Text('Leaderboard'),
          onTap: () {
            BlocProvider.of<LogrosListBloc>(context).add(LogrosListType5Selected());
            BlocProvider.of<LogrosListBloc>(context).add(LogrosListLoaded());
          },
        ),
      ],
      onChanged: (value) {
        setState(() {
          _typeOfLogro = value;  
        });
      },
    );
  }
}



class LogrosListBlocBuilder extends StatefulWidget {

  @override
  _LogrosListBlocBuilderState createState() => _LogrosListBlocBuilderState();
}

class _LogrosListBlocBuilderState extends State<LogrosListBlocBuilder> {
  List<LogroModel> logrosList = [];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LogrosListBloc, LogrosListState>(
      builder: (context, state) {
        if(state is LogrosListLoadInProgress){
          return Center(child: CircularProgressIndicator());
        }
        if(state is LogrosListLoadFailure){
          return Center(
            child: Column(  
              children: [
                Icon(Icons.error),
                Text('Hubo un error al cargar la información'),
              ],
            )
          );
        }
        if(state is LogrosListLoadSuccess){
          logrosList = state.logros;
          return Container(
            child: logrosList.length == 0 
            ?Center(child: Text('Logros no disponibles'))
            :Expanded(
              child: ListView.builder(
                itemCount: logrosList.length,
                itemBuilder: (context, i){
                  return CreateItem(context: context, logro: logrosList[i]);
                },
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}

class CreateItem extends StatelessWidget {

  final BuildContext context;
  final LogroModel logro;

  const CreateItem({
    Key key, 
    this.context, 
    this.logro
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      background: Container( 
        color: Colors.red,
      ),
      onDismissed: (direction) {
        RepositoryProvider.of<LogrosRepository>(context).deleteLogro(logro.id);
      },
      child: ListTile(   
        title: Text('${logro.name}'),
        subtitle: Text('${logro.description}'),
        onTap: () => Navigator.pushNamed(context, 'addLogro', arguments: logro),
      ),
    );
  }
}