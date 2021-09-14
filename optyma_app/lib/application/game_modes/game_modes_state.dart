part of 'game_modes_bloc.dart';

@freezed
class GameModesState with _$GameModesState {
  const factory GameModesState.chosingGameMode({
    @Default('') String gameMode,
    @Default(OperationType.none) OperationType operationType,
    @Default(Difficulty.none) Difficulty difficulty,
  }) = ChosingGameMode;

  const factory GameModesState.chosingOperation({
    required String gameMode,
    @Default(OperationType.none) OperationType operationType,
    @Default(Difficulty.none) Difficulty difficulty,
  }) = ChosingOperation;

  const factory GameModesState.chosingDifficulty({
    required String gameMode,
    required OperationType operationType,
    @Default(Difficulty.none) Difficulty difficulty,
  }) = ChosingDifficulty;

  const factory GameModesState.gameStarting({
    required String gameMode,
    required OperationType operationType,
    required Difficulty difficulty,
  }) = GameStarting;
}
