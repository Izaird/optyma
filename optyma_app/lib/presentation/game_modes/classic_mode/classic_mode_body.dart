import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:games_services/games_services.dart';
import 'package:optyma_app/application/game_modes/classic_mode/classic_mode_bloc.dart';
import 'package:optyma_app/application/game_modes/timer/timer_bloc.dart';
import 'package:optyma_app/domain/expressions/i_expression_facade.dart';
import 'package:optyma_app/presentation/game_modes/classic_mode/question_card.dart';
import 'package:optyma_app/presentation/game_modes/classic_mode/timer_text.dart';
import 'package:optyma_app/presentation/game_modes/classic_mode/top_bar.dart';

class ClassicModeBody extends StatelessWidget {
  const ClassicModeBody({
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ClassicModeBloc,ClassicModeState>(
      builder: (context, state){
        if(state.gameOver){
          int classicScore = BlocProvider.of<ClassicModeBloc>(context).state.score;
          int time = BlocProvider.of<ClassicModeBloc>(context).state.totalTime;
          int bestStreak = BlocProvider.of<ClassicModeBloc>(context).state.bestStreak;
          int correctAns = BlocProvider.of<ClassicModeBloc>(context).state.correctAnswers;
          if(GamesServices.isSignedIn==false){
            GamesServices.signIn();
          }
          if(state.operationType==OperationType.addition){
              GamesServices.submitScore(score: Score(androidLeaderboardID: "CgkIg5u-zPUVEAIQEw", value: classicScore));
              print("Submitted score");
            }
            else if(state.operationType==OperationType.substraction){
              GamesServices.submitScore(score: Score(androidLeaderboardID: "CgkIg5u-zPUVEAIQFA", value: classicScore));
              print("Submitted score");
            }
            else if(state.operationType==OperationType.multiplication){
              GamesServices.submitScore(score: Score(androidLeaderboardID: "CgkIg5u-zPUVEAIQFQ", value: classicScore));
              print("Submitted score");
            }
            else if(state.operationType==OperationType.division){
              GamesServices.submitScore(score: Score(androidLeaderboardID: "CgkIg5u-zPUVEAIQFg", value: classicScore));
              print("Submitted score");
            }
            else if(state.operationType==OperationType.combined){
              GamesServices.submitScore(score: Score(androidLeaderboardID: "CgkIg5u-zPUVEAIQFw", value: classicScore));
              print("Submitted score");
            }
            if(bestStreak>=10){//Perfeccionista
              GamesServices.unlock(achievement: Achievement(androidID: 'CgkIg5u-zPUVEAIQCw'));
            }
            /*if(correctAns>=7 && time<180){//Agil
              GamesServices.unlock(achievement: Achievement(androidID: 'CgkIg5u-zPUVEAIQDA'));
            }
            if(correctAns>=7 && time<120){//Veloz
              GamesServices.unlock(achievement: Achievement(androidID: 'CgkIg5u-zPUVEAIQDQ'));
            }*/
            if(correctAns>=7 && time<60){//Sub60
              GamesServices.unlock(achievement: Achievement(androidID: 'CgkIg5u-zPUVEAIQDg'));
            }
            if(state.difficulty==Difficulty.easy && classicScore>2500){//Academico
              GamesServices.unlock(achievement: Achievement(androidID: 'CgkIg5u-zPUVEAIQDw'));
            }
            if(state.difficulty==Difficulty.medium && classicScore>5000){//Estudioso
              GamesServices.unlock(achievement: Achievement(androidID: 'CgkIg5u-zPUVEAIQEA'));
            }
            if(state.difficulty==Difficulty.hard && classicScore>10000){//Erudito
              GamesServices.unlock(achievement: Achievement(androidID: 'CgkIg5u-zPUVEAIQEQ'));
            }
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text('Se acabo el juego \nTu puntuación: $classicScore\nTu tiempo: $time s\nTu mejor racha: $bestStreak',
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
          return Column(
            children:[
              TopBar(),
              TimerText(),
              QuestionCard(),
              //BackButton()
               ElevatedButton(onPressed: (){BlocProvider.of<ClassicModeBloc>(context).add(GameOver());},
                child: const Text("Finalizar"))
            ],
              
          );
        }
      }, 
      listener: (context, state){
        if(state.answered){
          BlocProvider.of<TimerBloc>(context).add(const TimerEvent.paused());
        }else{
          if(state.difficulty==Difficulty.easy){
            BlocProvider.of<TimerBloc>(context).add(const TimerEvent.started(30));
          }
          else if(state.difficulty==Difficulty.medium){
            BlocProvider.of<TimerBloc>(context).add(const TimerEvent.started(45));
          }

          else if(state.difficulty==Difficulty.hard){
            BlocProvider.of<TimerBloc>(context).add(const TimerEvent.started(60));
          }
          else{
            BlocProvider.of<TimerBloc>(context).add(const TimerEvent.started(20));
          }
        }
      }
    );
  }
}
