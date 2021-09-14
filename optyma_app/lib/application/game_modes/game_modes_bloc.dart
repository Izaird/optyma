import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:optyma_app/domain/expressions/i_expression_facade.dart';

part 'game_modes_event.dart';
part 'game_modes_state.dart';
part 'game_modes_bloc.freezed.dart';


@injectable
class GameModesBloc extends Bloc<GameModesEvent, GameModesState> {
  GameModesBloc() : super(ChosingGameMode());

  @override
  Stream<GameModesState> mapEventToState(
    GameModesEvent event,
  ) async* {
    yield* event.map(
      gameModeChosen: (e) async*{
        yield ChosingOperation(gameMode: e.gameMode);
      }, 
      operationChosen: (e) async*{
        yield ChosingDifficulty(
          gameMode: state.gameMode, 
          operationType: e.operation
        );
      }, 
      difficultyChosen: (e) async*{
        yield GameStarting(
          gameMode: state.gameMode, 
          operationType: state.operationType, 
          difficulty: e.difficulty,
        );
      }, 
    );
  }
}