import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:optyma_app/domain/expressions/i_expression_facade.dart';

part 'leaderboard_event.dart';
part 'leaderboard_state.dart';
part 'leaderboard_bloc.freezed.dart';


@injectable
class LeaderboardBloc extends Bloc<LeaderboardEvent, LeaderboardState> {
  LeaderboardBloc() : super(ChosingGameMode());

  @override
  Stream<LeaderboardState> mapEventToState(
    LeaderboardEvent event,
  ) async* {
    yield* event.map(
      gameModeChosen: (e) async*{
        yield ChosingOperation(gameMode: e.gameMode);
      }, 
      operationChosen: (e) async*{
        yield GameStarting(
          gameMode: state.gameMode, 
          operationType: e.operation, 
        );
      }, 
      /*difficultyChosen: (e) async*{
        yield GameStarting(
          gameMode: state.gameMode, 
          operationType: state.operationType, 
        );
      }, */
    );
  }
}