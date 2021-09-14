import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optyma_app/application/game_modes/game_modes_bloc.dart';
import 'package:optyma_app/domain/expressions/i_expression_facade.dart';
import 'package:optyma_app/domain/game_modes/category.dart';
import 'package:optyma_app/domain/game_modes/options.dart';


class GameModesBody extends StatelessWidget {
  const GameModesBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GameModesBloc, GameModesState>(
      listener: (context,state){
        if(state is GameStarting){
          final Options options = Options(
            operationType: state.operationType, 
            difficulty: state.difficulty
          );
          Navigator.popAndPushNamed(context, state.gameMode, arguments:options);
        }
      },
      builder: (context, state){
        if(state is ChosingGameMode){
          return GameModesGrid();
        }else if(state is ChosingOperation){
          return OperationsGrid();
        }else if(state is ChosingDifficulty){
          return DifficultyGrid();
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
      children: List.generate(gameCategories.length, (index){
        return ElevatedButton(
          onPressed: (){
            BlocProvider.of<GameModesBloc>(context)
              .add(GameModesEvent.gameModeChosen(gameMode: gameCategories[index].id));
          },
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(gameCategories[index].name),
                gameCategories[index].icon
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
            BlocProvider.of<GameModesBloc>(context)
              .add(GameModesEvent.operationChosen(operation: operationType!));
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

class DifficultyGrid extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 3,
      children: List.generate(difficultysCategories.length, (index){

        final Difficulty? difficulty = EnumToString.fromString(Difficulty.values, difficultysCategories[index].id);

        return ElevatedButton(
          onPressed: (){
            BlocProvider.of<GameModesBloc>(context)
              .add(GameModesEvent.difficultyChosen(difficulty: difficulty!));
          },
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(difficultysCategories[index].name),
                difficultysCategories[index].icon
              ],
            ),
          )
        );
      }),
    );
  }
}