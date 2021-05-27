import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optyma_app/bloc/logros_list/logros_list_bloc.dart';
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
    return Column();
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
          },
        ),
        DropdownMenuItem(
          value: 'Racha de respuestas',
          child: Text('Racha de respuestas'),
          onTap: () {
            BlocProvider.of<LogrosListBloc>(context).add(LogrosListType2Selected());
          },
        ),
        DropdownMenuItem(
          value: 'Racha de días',
          child: Text('Racha de días'),
          onTap: () {
            BlocProvider.of<LogrosListBloc>(context).add(LogrosListType3Selected());
          },
        ),
        DropdownMenuItem(
          value: 'Ejercicios realizados',
          child: Text('Ejercicios realizados'),
          onTap: () {
            BlocProvider.of<LogrosListBloc>(context).add(LogrosListType4Selected());
          },
        ),
        DropdownMenuItem(
          value: 'Leaderboard',
          child: Text('Leaderboard'),
          onTap: () {
            BlocProvider.of<LogrosListBloc>(context).add(LogrosListType5Selected());
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



class LogrosList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LogrosListBloc, LogrosListState>(
      builder: (context, state) {
        if(state is LogrosListInitial){
          return Text('Escoge un tipo de logro');
        }
        if(state is LogrosListBody)
        return Container();
      },
    );
  }
}