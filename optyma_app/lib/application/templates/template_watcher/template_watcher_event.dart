part of 'template_watcher_bloc.dart';

@freezed
class TemplateWatcherEvent with _$TemplateWatcherEvent {
  const factory TemplateWatcherEvent.watchAllStarted() = _WatchAllStarted;
  const factory TemplateWatcherEvent.templatesReceived(
    Either<TemplateFailure, List<Template>> failureOrTemplates
    ) = _TemplatesReceived;
}