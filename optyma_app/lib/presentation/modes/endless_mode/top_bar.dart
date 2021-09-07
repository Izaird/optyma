import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optyma_app/application/game_modes/endless_mode/endless_mode_bloc.dart';

class TopBar extends StatelessWidget {
  const TopBar() : super();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        const Icon(Icons.local_fire_department_outlined),
        Text('${BlocProvider.of<EndlessModeBloc>(context).state.streak}'),
        const Spacer(),
        Text('${BlocProvider.of<EndlessModeBloc>(context).state.score}'),
      ],
    );
  }
}