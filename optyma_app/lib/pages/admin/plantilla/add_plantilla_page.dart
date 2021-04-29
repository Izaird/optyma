import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:optyma_app/cubit/plantilla/plantilla_cubit.dart';
import 'package:optyma_app/repository/authentication_repository.dart';
import 'package:optyma_app/repository/plantillas_repository.dart';
import 'package:optyma_app/pages/admin/plantilla/add_plantilla_form.dart';


class AddPlantillaPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocProvider<PlantillaCubit>(  
          create: (_) => PlantillaCubit(
            authenticationRepository: RepositoryProvider.of<AuthenticationRepository>(context),
            plantillasRepository: RepositoryProvider.of<PlantillasRepository>(context),
          ),
          child: AddPlantillaForm(),
        ),
      ),
    );
  }

}