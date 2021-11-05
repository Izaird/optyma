part of 'template_form_bloc.dart';

@freezed
class TemplateFormEvent with _$TemplateFormEvent {
  const factory TemplateFormEvent.initialized(Option<Template> initialTemplateOption) = _Initialized;
  const factory TemplateFormEvent.expressionChanged(String expressionStr) = _ExpressionChanged;
  const factory TemplateFormEvent.valuesEasyChanged(String valuesStr) = _ValuesEasyChanged;
  const factory TemplateFormEvent.valuesMediumChanged(String valuesStr) = _ValuesMediumChanged;
  const factory TemplateFormEvent.valuesHardChanged(String valuesStr) = _ValuesHardChanged;
  const factory TemplateFormEvent.saved() = _Saved;
}