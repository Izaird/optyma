part of 'template_watcher_bloc.dart';

@freezed
class TemplateWatcherState with _$TemplateWatcherState {
  const factory TemplateWatcherState.initial() = _Initial;
  const factory TemplateWatcherState.loadInProgress() = _LoadInProgress;
  const factory TemplateWatcherState.loadSuccess(List<Template> templates) = _LoadSuccess;
  const factory TemplateWatcherState.loadFailure(TemplateFailure templateFailure) = _LoadFailure;
}