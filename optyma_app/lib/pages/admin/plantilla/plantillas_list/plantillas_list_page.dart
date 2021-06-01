import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optyma_app/bloc/plantillas_list/plantillas_list_bloc.dart';
import 'package:optyma_app/models/plantilla_model.dart';
import 'package:optyma_app/repository/plantillas_repository.dart';

class PlantillasListPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de plantillas'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocProvider(
          create: (context) => PlantillasListBloc(
            plantillasRepository : RepositoryProvider.of<PlantillasRepository>(context)),
          child: PlantillasListBody(), 
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.pushNamed(context, 'addPlantilla');
        },
      ),
    );
    
  }

}

class PlantillasListBody extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MenuTypesOfPlantillas(),
        PlantillasListBlocBuilder(),
      ],
    );
  }
}


class MenuTypesOfPlantillas extends StatefulWidget{
  @override
  _MenuTypesOfPlantillasState createState() => _MenuTypesOfPlantillasState();
}

class _MenuTypesOfPlantillasState extends State<MenuTypesOfPlantillas> {
  String _typeOfLogro ;
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      hint: Text('Tipos de plantilla'), 
      value: _typeOfLogro,
      items: <DropdownMenuItem>[
        DropdownMenuItem(
          value: 'Aritmética',
          child: Text('Aritmética'),
          onTap: () {
            BlocProvider.of<PlantillasListBloc>(context).add(PlantillasListAritSelected());
            BlocProvider.of<PlantillasListBloc>(context).add(PlantillasListLoaded());
          },
        ),
        DropdownMenuItem(
          value: 'Álgebra',
          child: Text('Álgebra'),
          onTap: () {
            BlocProvider.of<PlantillasListBloc>(context).add(PlantillasListAlgeSelected());
            BlocProvider.of<PlantillasListBloc>(context).add(PlantillasListLoaded());
          },
        ),
        DropdownMenuItem(
          value: 'Diferencial',
          child: Text('Cálculo Diferencial'),
          onTap: () {
            BlocProvider.of<PlantillasListBloc>(context).add(PlantillasListDifeSelected());
            BlocProvider.of<PlantillasListBloc>(context).add(PlantillasListLoaded());
          },
        ),
        DropdownMenuItem(
          value: 'Optimización',
          child: Text('Optimización'),
          onTap: () {
            BlocProvider.of<PlantillasListBloc>(context).add(PlantillasListOptiSelected());
            BlocProvider.of<PlantillasListBloc>(context).add(PlantillasListLoaded());
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



class PlantillasListBlocBuilder extends StatefulWidget {

  @override
  _PlantillasListBlocBuilderState createState() => _PlantillasListBlocBuilderState();
}

class _PlantillasListBlocBuilderState extends State<PlantillasListBlocBuilder> {
  List<PlantillaModel> plantillasList = [];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlantillasListBloc, PlantillasListState>(
      builder: (context, state) {
        if(state is PlantillasListLoadInProgress){
          return Center(child: CircularProgressIndicator());
        }
        if(state is PlantillasListLoadFailure){
          return Center(
            child: Column(  
              children: [
                Icon(Icons.error),
                Text('Hubo un error al cargar la información'),
              ],
            )
          );
        }
        if(state is PlantillasListLoadSuccess){
          plantillasList = state.plantillas;
          return Container(
            child: plantillasList.length == 0 
            ?Center(child: Text('Plantillas no disponibles'))
            :Expanded(
              child: ListView.builder(
                itemCount: plantillasList.length,
                itemBuilder: (context, i){
                  return CreateItem(context: context, plantilla: plantillasList[i]);
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
  final PlantillaModel plantilla;

  const CreateItem({
    Key key, 
    this.context, 
    this.plantilla
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      background: Container( 
        color: Colors.red,
      ),
      onDismissed: (direction) {
        RepositoryProvider.of<PlantillasRepository>(context).deletePlantilla(plantilla.id);
      },
      child: ListTile(   
        title: Text('${plantilla.sentence}'),
        subtitle: Text('${plantilla.expression}'),
        onTap: () => Navigator.pushNamed(context, 'addPlantilla', arguments: plantilla),
      ),
    );
  }
}