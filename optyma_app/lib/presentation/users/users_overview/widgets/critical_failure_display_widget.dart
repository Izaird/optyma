import 'package:flutter/cupertino.dart';
import 'package:optyma_app/domain/users/user_failure.dart';

class CriticalFailureDisplay extends StatelessWidget{
  final UserFailure failure;

  const CriticalFailureDisplay({
    Key? key, 
    required this.failure
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

}