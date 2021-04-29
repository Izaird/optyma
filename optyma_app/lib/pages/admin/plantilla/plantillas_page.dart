import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:optyma_app/bloc/plantillas/plantillas_bloc.dart';
import 'package:optyma_app/pages/admin/plantilla/plantillas_list.dart';
import 'package:optyma_app/repository/plantillas_repository.dart';


class PlantillasPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PlantillasBloc(
        plantillasRepository: RepositoryProvider.of<PlantillasRepository>(context))
        ..add(PlantillasLoaded()),

      child: Scaffold(
        appBar: AppBar(),
        body: PlantillasList(),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: (){
            Navigator.pushNamed(context, 'addPlantilla');
          },
        ),
      ),
    );
  }
}