// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optyma_app/application/game_modes/endless_mode/endless_mode_bloc.dart';
import 'package:optyma_app/presentation/game_modes/PvPLocal/question_card.dart';
import 'package:optyma_app/application/game_modes/pvp_mode/pvp_mode_bloc.dart';
import 'package:optyma_app/presentation/game_modes/PvPLocal/question_card2.dart';
import 'package:optyma_app/application/game_modes/timer/timer_bloc.dart';
class PvPBody extends StatelessWidget {
  const PvPBody({
    Key? key,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PvpModeBloc,PvpModeState>(
      builder: (context, state){
        int player1Score = BlocProvider.of<PvpModeBloc>(context).state.score1;
        int player2Score = BlocProvider.of<PvpModeBloc>(context).state.score2;
        if(state.gameOver){
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text('Se acabo el juego \nPuntuación jugador 1: $player1Score \nPuntuación jugador 2: $player2Score ' ,
                style: const TextStyle( 
                  fontSize: 30,
                  ),
                ),
              ),
              const Center(
                child: BackButton(),
              ),
            ],
          );
        }else{
          return Scaffold(
          body: SafeArea(  
            child: Padding(  
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  //Expanded(child: QuestionCard()),
                  Expanded(
                    child: RotatedBox (
                      quarterTurns: 2,
                      child: QuestionCard2()
                    )
                  ),
                  Container(
                    height: 40,
                    //color: Colors.grey,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('$player1Score',
                          textScaleFactor: 1.8,
                        ),
                        RotatedBox(
                          quarterTurns: 2,
                          child: Text('$player2Score',
                            textScaleFactor: 1.8,),
                          )
                      ],
                    ),
                  ),
                  Expanded(
                    //child: Container(
                      //color: Colors.blueGrey,
                      child: QuestionCard(),
                    )
                  //),
                ]
              ),
            ),
          ),
          );
        }
        
      },
      listener: (context,state){
        if(state.answered && state.answeredj2){
          BlocProvider.of<TimerBloc>(context).add(const TimerEvent.paused());
        }else{
          BlocProvider.of<TimerBloc>(context).add(const TimerEvent.started(30));
        }
      }
    );
  }
}