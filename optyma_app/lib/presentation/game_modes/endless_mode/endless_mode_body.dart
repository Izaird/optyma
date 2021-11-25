import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:games_services/games_services.dart';
import 'package:optyma_app/application/game_modes/endless_mode/endless_mode_bloc.dart';
import 'package:optyma_app/application/game_modes/timer/timer_bloc.dart';
import 'package:optyma_app/domain/expressions/i_expression_facade.dart';
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
          int endlessScore = BlocProvider.of<EndlessModeBloc>(context).state.score;
          int bestStreak = BlocProvider.of<EndlessModeBloc>(context).state.bestStreak;
          if(GamesServices.isSignedIn==false){
            GamesServices.signIn();
          }
          if(state.operationType==OperationType.addition){
              GamesServices.submitScore(score: Score(androidLeaderboardID: "CgkIg5u-zPUVEAIQBg", value: endlessScore));
              print("Submitted score");
            }
            else if(state.operationType==OperationType.substraction){
              GamesServices.submitScore(score: Score(androidLeaderboardID: "CgkIg5u-zPUVEAIQCA", value: endlessScore));
              print("Submitted score");
            }
            else if(state.operationType==OperationType.multiplication){
              GamesServices.submitScore(score: Score(androidLeaderboardID: "CgkIg5u-zPUVEAIQCQ", value: endlessScore));
              print("Submitted score");
            }
            else if(state.operationType==OperationType.division){
              GamesServices.submitScore(score: Score(androidLeaderboardID: "CgkIg5u-zPUVEAIQCg", value: endlessScore));
              print("Submitted score");
            }
            else if(state.operationType==OperationType.combined){
              GamesServices.submitScore(score: Score(androidLeaderboardID: "CgkIg5u-zPUVEAIQEg", value: endlessScore));
              print("Submitted score");
            }
            if(bestStreak>=5){
              GamesServices.unlock(achievement: Achievement(androidID: 'CgkIg5u-zPUVEAIQAg'));
            }
            if(bestStreak>=10){
              GamesServices.unlock(achievement: Achievement(androidID: 'CgkIg5u-zPUVEAIQBw'));
            }
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text('Se acabo el juego \nTu puntuación: $endlessScore\nTu mejor racha: $bestStreak',
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
               ElevatedButton(onPressed: (){BlocProvider.of<EndlessModeBloc>(context).add(GameOver());},
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
