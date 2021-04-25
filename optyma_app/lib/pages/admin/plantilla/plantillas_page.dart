import 'package:flutter/material.dart';


class PlantillasPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(),
      body: Center(
        child: Text('PlantillasPage'),
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