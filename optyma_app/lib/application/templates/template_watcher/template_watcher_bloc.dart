import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:optyma_app/domain/templates/i_template_repository.dart';
import 'package:optyma_app/domain/templates/template.dart';
import 'package:optyma_app/domain/templates/template_failure.dart';

part 'template_watcher_event.dart';
part 'template_watcher_state.dart';
part 'template_watcher_bloc.freezed.dart';


@injectable
class TemplateWatcherBloc extends Bloc<TemplateWatcherEvent, TemplateWatcherState> {

  final ITemplateRepository _templateRepository;

  StreamSubscription<Either<TemplateFailure, List<Template>>>? _templateStreamSubscription;


  TemplateWatcherBloc(this._templateRepository): super(const TemplateWatcherState.initial());


  @override 
  Stream<TemplateWatcherState> mapEventToState(TemplateWatcherEvent event) async *{
    yield* event.map(
      watchAllStarted: (e) async* {
        yield const TemplateWatcherState.loadInProgress();
        await _templateStreamSubscription?.cancel();

        _templateStreamSubscription = _templateRepository.watchAll()
          .listen(
            (failureOrTemplates) => add(TemplateWatcherEvent.templatesReceived(failureOrTemplates))
          );
      },
      templatesReceived: (e) async* {
        yield e.failureOrTemplates.fold(
          (f) => TemplateWatcherState.loadFailure(f), 
          (template) => TemplateWatcherState.loadSuccess(template)
        );
      }
    );
  }

  @override 
  Future<void> close()async{
    await _templateStreamSubscription?.cancel();
    return super.close();
  }
}

