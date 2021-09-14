part of 'game_modes_bloc.dart';

@freezed
class GameModesEvent with _$GameModesEvent {
  const factory GameModesEvent.gameModeChosen({
    required String gameMode,
  }) = GameModeChosen;

  const factory GameModesEvent.operationChosen({
    required OperationType operation,
  }) = OperationChosen;

  const factory GameModesEvent.difficultyChosen({
    required Difficulty difficulty,
  }) = DifficultyChosen;
}