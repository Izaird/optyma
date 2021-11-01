part of 'template_form_bloc.dart';

@freezed
class TemplateFormState with _$TemplateFormState {
  const factory TemplateFormState({
    required Template template,
    required bool showErrorMessages,
    required bool isEditing,
    required bool isSaving,
    required Option<Either<TemplateFailure, Unit>> saveFailureOrSuccessOption,
  }) = _TemplateFormState;

  factory TemplateFormState.initial() => TemplateFormState(
    template: Template.empty(), 
    showErrorMessages: false, 
    isEditing: false, 
    isSaving: false, 
    saveFailureOrSuccessOption: none()
  );
}
