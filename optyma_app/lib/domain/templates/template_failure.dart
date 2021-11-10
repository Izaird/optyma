

import 'package:freezed_annotation/freezed_annotation.dart';

part 'template_failure.freezed.dart';

@freezed
class TemplateFailure with _$TemplateFailure{
  const factory TemplateFailure.unexpected() = _Unexpected;
  const factory TemplateFailure.unableToUpdate() = _UnableToUpdated;
  const factory TemplateFailure.noTemplates() = _NoTemplates;
  const factory TemplateFailure.insufficientPermission() = _InsufficientPermission;
}