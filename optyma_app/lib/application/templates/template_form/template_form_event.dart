part of 'template_form_bloc.dart';

@freezed
class TemplateFormEvent with _$TemplateFormEvent {
  const factory TemplateFormEvent.initialized(Option<Template> initialTemplateOption) = _Initialized;
  const factory TemplateFormEvent.expressionChanged(String expressionStr) = _ExpressionChanged;
  const factory TemplateFormEvent.valuesChanged(String valuesStr) = _ValuesChanged;
  const factory TemplateFormEvent.saved() = _Saved;
}