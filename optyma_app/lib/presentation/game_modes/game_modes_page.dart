import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optyma_app/application/game_modes/game_modes_bloc.dart';
import 'package:optyma_app/injection.dart';
import 'package:optyma_app/presentation/game_modes/game_modes_body.dart';


class GameModesPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<GameModesBloc>(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Juegos'),
        ),
        body: Padding(
          padding: EdgeInsets.all(8.0),
          child: GameModesBody(),
        )
      ),
    );
  }
}