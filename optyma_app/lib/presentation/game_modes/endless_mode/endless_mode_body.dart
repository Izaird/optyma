import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optyma_app/application/game_modes/endless_mode/endless_mode_bloc.dart';
import 'package:optyma_app/application/game_modes/timer/timer_bloc.dart';
import 'package:optyma_app/presentation/game_modes/endless_mode/question_card.dart';
import 'package:optyma_app/presentation/game_modes/endless_mode/timer_text.dart';
import 'package:optyma_app/presentation/game_modes/endless_mode/top_bar.dart';

class EndlessModeBody extends StatelessWidget {
  const EndlessModeBody({
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EndlessModeBloc,EndlessModeState>(
      builder: (context, state){
        if(state.gameOver){
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text('Se acabo el juego \nTu puntuación: ${BlocProvider.of<EndlessModeBloc>(context).state.score}',
                style: const TextStyle( 
                  fontSize: 30,
                  ),
                ),
              ),
              Center(
                child: BackButton(),
              ),
            ],
          );
        }else{
          return Column(
            children:[
              TopBar(),
              TimerText(),
              QuestionCard(),
              BackButton()
            ],
              
          );
        }
      }, 
      listener: (context, state){
        if(state.answered){
          BlocProvider.of<TimerBloc>(context).add(const TimerEvent.paused());
        }else{
          BlocProvider.of<TimerBloc>(context).add(const TimerEvent.started(30));
        }
      }
    );
  }
}
