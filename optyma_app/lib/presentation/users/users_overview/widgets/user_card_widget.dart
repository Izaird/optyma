import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:optyma_app/domain/users/user.dart';

class UserCard extends StatelessWidget{
  final User user;

  const UserCard({
    Key? key, 
    required this.user
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: (){
          Navigator.pushNamed(context, 'usersForm', arguments: user);
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(user.emailAddress.getOrCrash()),
        ),
      )
      
    );
  }

}