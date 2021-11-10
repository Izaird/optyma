part of 'template_actor_bloc.dart';

@freezed
class TemplateActorEvent with _$TemplateActorEvent {
  const factory TemplateActorEvent.deleted(Template template) = _Deleted;
}