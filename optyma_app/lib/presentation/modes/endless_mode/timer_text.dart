import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optyma_app/application/game_modes/endless_mode/endless_mode_bloc.dart';
import 'package:optyma_app/application/game_modes/timer/timer_bloc.dart';

class TimerText extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    final duration = context.select((TimerBloc bloc) => bloc.state.duration);
    final minuteStr = ((duration / 60) % 60).floor().toString().padLeft(2,'0');
    final secondsStr = (duration % 60).floor().toString().padLeft(2, '0');

    return BlocListener<TimerBloc, TimerState>(
      listener: (context, state) {
        if(state is RunComplete){
          BlocProvider.of<EndlessModeBloc>(context).add(const TimeOver());
        }
      },
      child:  Text('$minuteStr:$secondsStr',
      style: Theme.of(context).textTheme.headline3,
      ),
    );
  }
}
