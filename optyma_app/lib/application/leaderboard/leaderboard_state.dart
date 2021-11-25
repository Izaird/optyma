part of 'leaderboard_bloc.dart';

@freezed
class LeaderboardState with _$LeaderboardState {
  const factory LeaderboardState.chosingGameMode({
    @Default('') String gameMode,
    @Default(OperationType.none) OperationType operationType,
  }) = ChosingGameMode;

  const factory LeaderboardState.chosingOperation({
    required String gameMode,
    @Default(OperationType.none) OperationType operationType,
  }) = ChosingOperation;

  /*const factory LeaderboardState.chosingDifficulty({
    required String gameMode,
    required OperationType operationType,
  }) = ChosingDifficulty;*/

  const factory LeaderboardState.gameStarting({
    required String gameMode,
    required OperationType operationType,
  }) = GameStarting;
}
