part of 'leaderboard_bloc.dart';

@freezed
class LeaderboardEvent with _$LeaderboardEvent {
  const factory LeaderboardEvent.gameModeChosen({
    required String gameMode,
  }) = GameModeChosen;

  const factory LeaderboardEvent.operationChosen({
    required OperationType operation,
  }) = OperationChosen;

  /*const factory LeaderboardEvent.difficultyChosen({
    required Difficulty difficulty,
  }) = DifficultyChosen;*/
}