import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:optyma_app/domain/templates/i_template_repository.dart';
import 'package:optyma_app/domain/templates/template.dart';
import 'package:optyma_app/domain/templates/template_failure.dart';
import 'package:optyma_app/domain/templates/value_objects.dart';

part 'template_form_event.dart';
part 'template_form_state.dart';
part 'template_form_bloc.freezed.dart';


@injectable
class TemplateFormBloc extends Bloc<TemplateFormEvent, TemplateFormState> {

  final ITemplateRepository _templateRepository;
  TemplateFormBloc(this._templateRepository): super(TemplateFormState.initial());


  @override 
  Stream<TemplateFormState> mapEventToState(TemplateFormEvent event) async *{
    yield* event.map(
      initialized: (e) async* {
        yield e.initialTemplateOption.fold(
          () => state, 
          (initialTemplate) => state.copyWith(
            template: initialTemplate,
            isEditing: true,
          )
        );
      }, 
      expressionChanged: (e) async* {
        yield state.copyWith(
          template: state.template.copyWith(expression: Expression(e.expressionStr)),
          saveFailureOrSuccessOption: none()
        );
      }, 
      valuesEasyChanged: (e) async*{
        yield state.copyWith(
          template: state.template.copyWith(valuesEasy: Values(e.valuesStr)),
        );
      },
      valuesMediumChanged: (e) async*{
        yield state.copyWith(
          template: state.template.copyWith(valuesMedium: Values(e.valuesStr)),
        );
      },
      valuesHardChanged: (e) async*{
        yield state.copyWith(
          template: state.template.copyWith(valuesHard: Values(e.valuesStr)),
        );
      },
      saved: (e) async* {
        Either<TemplateFailure, Unit>? failureOrSuccess;

        yield state.copyWith(
          isSaving: true,
          saveFailureOrSuccessOption: none()
        );
        

        if(state.template.expression.isValid()){
          failureOrSuccess = state.isEditing
            ? await _templateRepository.update(state.template)
            : await _templateRepository.create(state.template);
          
        }

        yield state.copyWith(
          isSaving: false,
          showErrorMessages: true,
          saveFailureOrSuccessOption: optionOf(failureOrSuccess)
        );
      }
    );
  }
}