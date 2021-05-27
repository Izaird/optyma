import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optyma_app/bloc/logros_list/logros_list_bloc.dart';
import 'package:optyma_app/repository/logros_repository.dart';


class LogrosPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LogrosListBloc(
        logrosRepository: RepositoryProvider.of<LogrosRepository>(context)),
      child: Logros(), 
    );
    
  }

}

class Logros extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Logros')),
      body: Column(
        children: [
          MenuTypesOfLogros(),
          LogrosList(),
        ],
      ), 
     floatingActionButton: FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () {
        Navigator.pushNamed(context, 'addLogro');
      },
     ), 

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
            BlocProvider.of<LogrosListBloc>(context).add(LogrosListType1Loaded());
          },
        ),
        DropdownMenuItem(
          value: 'Racha de respuestas',
          child: Text('Racha de respuestas'),
          onTap: () {
              
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
        if(state is Logros)
        return Container();
      },
    );
  }
}