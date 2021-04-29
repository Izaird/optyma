import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:optyma_app/bloc/plantillas/plantillas_bloc.dart';
import 'package:optyma_app/models/plantilla_model.dart';
import 'package:optyma_app/repository/logros_repository.dart';
import 'package:optyma_app/repository/plantillas_repository.dart';

class PlantillasList extends StatefulWidget {

  @override
  _PlantillasListState createState() => _PlantillasListState();
}

class _PlantillasListState extends State<PlantillasList> {

  List<PlantillaModel> plantillasList = [];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlantillasBloc, PlantillasState>(
      builder: (context, state){
        if(state is PlantillasLoadInProgress){
          return Center(child: CircularProgressIndicator(),);
        }
        if(state is PlantillasLoadFailure){
          return Center( 
            child: Column(  
              children: [
                Icon(Icons.error),
                Text('Hubo un error al cargar la información')
              ],
            ),
          );
        }
        if(state is PlantillasLoadSuccess){
          plantillasList = state.plantillas;
          return Container(
            child: plantillasList.length == 0
            ? Center(child: Text('Logros no disponibles'),)
            : ListView.builder(
              itemCount: plantillasList.length,
              itemBuilder: (context, i){
                return _createItem(context, plantillasList[i]);

              },
            ),
          );
        }
        return Container();
      },
    );
  }

  Widget _createItem(BuildContext context, PlantillaModel plantilla){

    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.red,
      ),
      onDismissed: (direction) {
        RepositoryProvider.of<PlantillasRepository>(context).deletePlantilla(plantilla.id);
      },
      child: ListTile(
        title: Text('${plantilla.exp}'),
        subtitle: Text('${plantilla.sentencia}'),
        onTap: () => Navigator.pushNamed(context, 'addPlantilla', arguments: plantilla),
      ),
    );
  }
}