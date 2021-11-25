import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optyma_app/application/leaderboard/leaderboard_bloc.dart';
import 'package:optyma_app/domain/expressions/i_expression_facade.dart';
import 'package:optyma_app/domain/game_modes/category.dart';
import 'package:optyma_app/domain/game_modes/options.dart';
import 'package:games_services/games_services.dart';

class LeaderbordsBody extends StatelessWidget {
  const LeaderbordsBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LeaderboardBloc , LeaderboardState>(
      listener: (context,state){
        if(state is GameStarting){
          if(state.gameMode=="endless-mode"){
            if(state.operationType==OperationType.addition){
              GamesServices.showLeaderboards(androidLeaderboardID: "CgkIg5u-zPUVEAIQBg");
              Navigator.popAndPushNamed(context, 'leaderboards');
            }
            else if(state.operationType==OperationType.substraction){
              GamesServices.showLeaderboards(androidLeaderboardID: "CgkIg5u-zPUVEAIQCA");
              Navigator.popAndPushNamed(context, 'leaderboards');
            }
            else if(state.operationType==OperationType.multiplication){
              GamesServices.showLeaderboards(androidLeaderboardID: "CgkIg5u-zPUVEAIQCQ");
              Navigator.popAndPushNamed(context, 'leaderboards');
            }
            else if(state.operationType==OperationType.division){
              GamesServices.showLeaderboards(androidLeaderboardID: "CgkIg5u-zPUVEAIQCg");
              Navigator.popAndPushNamed(context, 'leaderboards');
            }
            else if(state.operationType==OperationType.combined){
              GamesServices.showLeaderboards(androidLeaderboardID: "CgkIg5u-zPUVEAIQEg");
              Navigator.popAndPushNamed(context, 'leaderboards');
            }
            else{
              Navigator.pop(context);
            }

          }
          else if(state.gameMode=="classic-mode"){
            if(state.operationType==OperationType.addition){
              GamesServices.showLeaderboards(androidLeaderboardID: "CgkIg5u-zPUVEAIQEw");
              Navigator.popAndPushNamed(context, 'leaderboards');
            }
            else if(state.operationType==OperationType.substraction){
              GamesServices.showLeaderboards(androidLeaderboardID: "CgkIg5u-zPUVEAIQFA");
              Navigator.popAndPushNamed(context, 'leaderboards');
            }
            else if(state.operationType==OperationType.multiplication){
              GamesServices.showLeaderboards(androidLeaderboardID: "CgkIg5u-zPUVEAIQFQ");
              Navigator.popAndPushNamed(context, 'leaderboards');
            }
            else if(state.operationType==OperationType.division){
              GamesServices.showLeaderboards(androidLeaderboardID: "CgkIg5u-zPUVEAIQFg");
              Navigator.popAndPushNamed(context, 'leaderboards');
            }
            else if(state.operationType==OperationType.combined){
              GamesServices.showLeaderboards(androidLeaderboardID: "CgkIg5u-zPUVEAIQFw");
              //Navigator.pushNamed(context, 'leaderboards');
              Navigator.popAndPushNamed(context, 'leaderboards');
            }
            else{
              Navigator.pop(context);
            }
          }
          /*final Options options = Options(
            operationType: state.operationType, 
          );*/
          //Navigator.popAndPushNamed(context, state.gameMode, arguments:options);
        }
      },
      builder: (context, state){
        if(state is ChosingGameMode){
          return GameModesGrid();
        }else if(state is ChosingOperation){
          return OperationsGrid();
        }
        return Container();
      }
    );
  }
}

class GameModesGrid extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 2,
      children: List.generate(gameCategoriesLeader.length, (index){
        return ElevatedButton(
          onPressed: (){
            BlocProvider.of<LeaderboardBloc>(context)
              .add(LeaderboardEvent.gameModeChosen(gameMode: gameCategoriesLeader[index].id));
          },
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(gameCategoriesLeader[index].name),
                gameCategoriesLeader[index].icon
              ],
            ),
          )
        );
      }),
    );
  }
}

class OperationsGrid extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 2,
      children: List.generate(operationsCategories.length, (index){

        final OperationType? operationType = EnumToString.fromString(OperationType.values, operationsCategories[index].id);

        return ElevatedButton(
          onPressed: (){
            BlocProvider.of<LeaderboardBloc>(context)
              .add(LeaderboardEvent.operationChosen(operation: operationType!));
          },
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(operationsCategories[index].name),
                operationsCategories[index].icon
              ],
            ),
          )
        );
      }),
    );
  }
}

