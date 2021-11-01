import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:optyma_app/domain/core/value_objects.dart';
import 'package:optyma_app/domain/templates/value_objects.dart';

part 'template.freezed.dart';

@freezed
class Template with _$Template{
  const Template._();

  const factory Template({
    required UniqueId id,
    required Expression expression,
  }) = _Template;

  factory Template.empty() => Template(
    id: UniqueId.fromUniqueString(''), 
    expression: Expression('')
  );

}