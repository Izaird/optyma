import 'package:flutter/material.dart';

//TODO: Implement this page  
class AdminsPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text('AdminsPage'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.pushNamed(context, 'addAdmin');
        },
      ),
    );
  }
}