import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optyma_app/application/game_modes/endless_mode/endless_mode_bloc.dart';
import 'package:optyma_app/application/game_modes/timer/timer_bloc.dart';
import 'package:optyma_app/domain/game_modes/options.dart';
import 'package:optyma_app/injection.dart';
import 'package:optyma_app/presentation/game_modes/endless_mode/endless_mode_body.dart';


class EndlessModePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final options = ModalRoute.of(context)!.settings.arguments as Options;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<EndlessModeBloc>()
          ..add(EndlessModeEvent.started(options.operationType, options.difficulty))
        ),
        BlocProvider(create: (context) => getIt<TimerBloc>()),
      ], 
      child: const Scaffold(
        body: SafeArea(  
          child: Padding(  
            padding: EdgeInsets.all(8.0),
            child: EndlessModeBody(),
          ),
        ),
      )
    );
  }
}
