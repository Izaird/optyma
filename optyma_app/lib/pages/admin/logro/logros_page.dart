import 'package:flutter/material.dart';


class LogrosPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
  return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text('LogrosPage'),
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