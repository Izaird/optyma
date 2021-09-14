import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:optyma_app/domain/expressions/i_expression_facade.dart';

part 'options.freezed.dart';

@freezed
class Options with _$Options{
  const factory Options({
    required OperationType operationType,
    required Difficulty difficulty,
  }) = _Options;
}