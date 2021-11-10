part of 'template_actor_bloc.dart';

@freezed
class TemplateActorState with _$TemplateActorState {
  const factory TemplateActorState.initial() = _Initial;
  const factory TemplateActorState.actionInProgress() = _ActionInProgress;
  const factory TemplateActorState.deleteFailure(TemplateFailure templateFailure) = 
    _DeleteFailure;
  const factory TemplateActorState.deleteSuccess() = _DeleteSuccess;
}
