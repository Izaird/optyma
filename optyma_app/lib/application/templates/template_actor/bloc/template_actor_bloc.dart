import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:optyma_app/domain/templates/i_template_repository.dart';
import 'package:optyma_app/domain/templates/template.dart';
import 'package:optyma_app/domain/templates/template_failure.dart';

part 'template_actor_event.dart';
part 'template_actor_state.dart';
part 'template_actor_bloc.freezed.dart';


@injectable
class TemplateActorBloc extends Bloc<TemplateActorEvent, TemplateActorState>{
  final ITemplateRepository _templateRepository;

  TemplateActorBloc(this._templateRepository) : super(const TemplateActorState.initial());

  @override  
  Stream<TemplateActorState> mapEventToState(TemplateActorEvent event) async*{
    yield const TemplateActorState.actionInProgress();
    final possibleFailure = await _templateRepository.delete(event.template);
    yield possibleFailure.fold(
      (f) => TemplateActorState.deleteFailure(f), 
      (_) => const TemplateActorState.deleteSuccess()
    );
  }
}