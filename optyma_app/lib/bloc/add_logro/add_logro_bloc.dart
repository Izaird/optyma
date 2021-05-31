import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:optyma_app/models/logro_model.dart';
import 'package:optyma_app/repository/logros_repository.dart';
import 'package:optyma_app/utils/constants.dart';

part 'add_logro_event.dart';
part 'add_logro_state.dart';

class AddLogroBloc extends Bloc<AddLogroEvent, AddLogroState> {
  AddLogroBloc({@required LogrosRepository logrosRepository})
  : assert(logrosRepository != null),
  _logrosRepository = logrosRepository,
   super(AddLogroState());

  final LogrosRepository _logrosRepository;

  @override
  Stream<AddLogroState> mapEventToState(AddLogroEvent event) async* {

    if(event is AddLogroType1Selected){
      yield* _mapAddLogroType1SelectedToState();
    }
    if(event is AddLogroType2Selected){
      yield* _mapAddLogroType2SelectedToState();
    }
    if(event is AddLogroType3Selected){
      yield* _mapAddLogroType3SelectedToState();
    }
    if(event is AddLogroType4Selected){
      yield* _mapAddLogroType4SelectedToState();
    }
    if(event is AddLogroType5Selected){
      yield* _mapAddLogroType5SelectedToState();
    }
    if(event is AddLogroNameChanged){
      yield* _mapAddLogroNameChangedToState(event);
    }
    if(event is AddLogroDifficultyChanged){
      yield* _mapAddLogroDifficultyChangedToState(event);
    }
    if(event is AddLogroSubjectChanged){
      yield* _mapAddLogroSubjectChangedToState(event);
    }
    if(event is AddLogroNumberOfDaysChanged){
      yield* _mapAddLogroNumberOfDaysChangedToState(event);
    }
    if(event is AddLogroNumberOfExercisesChanged){
      yield* _mapAddLogroNumberOfExercisesChangedToState(event);
    }
    if(event is AddLogroNumberOfAnswersChanged){
      yield* _mapAddLogroNumberOfAnswersChangedToState(event);
    }
    if(event is AddLogroFormSubmitted){
      yield* _mapAddLogroFormSubmittedToState();
    }
    if(event is UpdateLogroFormSubmitted){
      yield* _mapUpdateLogroFormSubmittedToState(event);
    }
    if(event is AddLogroFormValidated){
      yield* _mapAddLogroFormValidatedToState();
    }
  }

  Stream<AddLogroState> _mapAddLogroType1SelectedToState() async *{
    yield state.copyWith(logroType: LogroType.nive);
  }

  Stream<AddLogroState> _mapAddLogroType2SelectedToState() async *{
    yield state.copyWith(logroType: LogroType.rRes);
  }

  Stream<AddLogroState> _mapAddLogroType3SelectedToState() async *{
    yield state.copyWith(logroType: LogroType.rDia);
  }

  Stream<AddLogroState> _mapAddLogroType4SelectedToState() async *{
    yield state.copyWith(logroType: LogroType.eRes);
  }

  Stream<AddLogroState> _mapAddLogroType5SelectedToState() async *{
    yield state.copyWith(logroType: LogroType.lead);
  }

  Stream<AddLogroState> _mapAddLogroNameChangedToState(AddLogroNameChanged event) async *{
    yield state.copyWith(name: event.name);
  }

  Stream<AddLogroState> _mapAddLogroDifficultyChangedToState(AddLogroDifficultyChanged event) async *{
    yield state.copyWith(difficulty: event.difficulty);
  }

  Stream<AddLogroState> _mapAddLogroSubjectChangedToState(AddLogroSubjectChanged event) async *{
    yield state.copyWith(subject: event.subject);
  }

  Stream<AddLogroState> _mapAddLogroNumberOfDaysChangedToState(AddLogroNumberOfDaysChanged event) async *{
    yield state.copyWith(numberOfDays: event.numberOfDays);
  }

  Stream<AddLogroState> _mapAddLogroNumberOfExercisesChangedToState(AddLogroNumberOfExercisesChanged event) async *{
    yield state.copyWith(numberOfExercises: event.numberOfExercises);
  }

  Stream<AddLogroState> _mapAddLogroNumberOfAnswersChangedToState(AddLogroNumberOfAnswersChanged event) async *{
    yield state.copyWith(numberOfAnswers: event.numberOfAnswers);
  }

  Stream<AddLogroState> _mapAddLogroFormValidatedToState() async *{
    //Form has been validated
    yield state.copyWith(status: FormStatus.validated);
  }

  Stream<AddLogroState> _mapAddLogroFormSubmittedToState() async *{
    if(state.logroType == LogroType.nive){
      //Form not validated
      if(state.status != FormStatus.validated) return;
      yield state.copyWith(description: 'Supera ${difficultys[state.difficulty]} en un ejercicio de ${subjects[state.subject]}');

      //Submission in progress
      yield state.copyWith(status: FormStatus.submissionInProgress);

      try{
        await _logrosRepository.addLogroNive(
          LogroModel(
            type        : state.logroType.index,
            name        : state.name,
            description : state.description,
            difficulty  : state.difficulty,
            subject     : state.subject,
          )
        );

        //Submission was a success 
        yield state.copyWith(status: FormStatus.submissionSuccess);

      } on Exception{

        //Submission was a failure
        yield state.copyWith(status: FormStatus.submissionFailure);

      }

    }

    if(state.logroType == LogroType.rRes){
      //Form not validated
      if(state.status != FormStatus.validated) return;
      yield state.copyWith(description: 'Racha de ${state.numberOfAnswers} respuestas correctas consecutivas en cualquier tema en la máxima dificultad');

      //Submission in progress
      yield state.copyWith(status: FormStatus.submissionInProgress);

      try{
        await _logrosRepository.addLogroRres(
          LogroModel(
            type            : state.logroType.index,
            name            : state.name,
            description     : state.description,
            numberOfAnswers : state.numberOfAnswers,
          )
        );

        //Submission was a success 
        yield state.copyWith(status: FormStatus.submissionSuccess);

      } on Exception{

        //Submission was a failure
        yield state.copyWith(status: FormStatus.submissionFailure);

      }

    }
    if(state.logroType == LogroType.rDia){
      //Form not validated
      if(state.status != FormStatus.validated) return;
      yield state.copyWith(description: 'Racha de ${state.numberOfDays} días consecutivos');

      //Submission in progress
      yield state.copyWith(status: FormStatus.submissionInProgress);

      try{
        await _logrosRepository.addLogroRdia(
          LogroModel(
            type        : state.logroType.index,
            name        : state.name,
            description : state.description,
            numberOfDays: state.numberOfDays,
          )
        );

        //Submission was a success 
        yield state.copyWith(status: FormStatus.submissionSuccess);

      } on Exception{

        //Submission was a failure
        yield state.copyWith(status: FormStatus.submissionFailure);

      }

    }
    if(state.logroType == LogroType.eRes){
      //Form not validated
      if(state.status != FormStatus.validated) return;
      yield state.copyWith(description: 'Realiza ${state.numberOfExercises} ejercicios de cualquier tema');

      //Submission in progress
      yield state.copyWith(status: FormStatus.submissionInProgress);

      try{
        await _logrosRepository.addLogroEres(
          LogroModel(
            type              : state.logroType.index,
            name              : state.name,
            description       : state.description,
            numberOfExercises : state.numberOfExercises,
          )
        );

        //Submission was a success 
        yield state.copyWith(status: FormStatus.submissionSuccess);

      } on Exception{

        //Submission was a failure
        yield state.copyWith(status: FormStatus.submissionFailure);

      }

    }
    if(state.logroType == LogroType.lead){
      //Form not validated
      if(state.status != FormStatus.validated) return;
      yield state.copyWith(description: 'Consigue una puntación dentro de un leaderboard');

      //Submission in progress
      yield state.copyWith(status: FormStatus.submissionInProgress);

      try{
        await _logrosRepository.addLogroLead(
          LogroModel(
            type        : state.logroType.index,
            name        : state.name,
            description : state.description,
            subject     : state.subject,
          )
        );

        //Submission was a success 
        yield state.copyWith(status: FormStatus.submissionSuccess);

      } on Exception{

        //Submission was a failure
        yield state.copyWith(status: FormStatus.submissionFailure);

      }

    }
  }

  Stream<AddLogroState> _mapUpdateLogroFormSubmittedToState(UpdateLogroFormSubmitted event) async *{
    if(state.logroType == LogroType.nive){
      //Form not validated
      if(state.status != FormStatus.validated) return;
      yield state.copyWith(description: 'Supera ${difficultys[state.difficulty]} en un ejercicio de ${subjects[state.subject]}');

      //Submission in progress
      yield state.copyWith(status: FormStatus.submissionInProgress);

      try{
        await _logrosRepository.updateLogroNive(
          LogroModel(
            id          : event.id,
            type        : state.logroType.index,
            name        : state.name,
            description : state.description,
            difficulty  : state.difficulty,
            subject     : state.subject,
          )
        );

        //Submission was a success 
        yield state.copyWith(status: FormStatus.submissionSuccess);

      } on Exception{

        //Submission was a failure
        yield state.copyWith(status: FormStatus.submissionFailure);

      }

    }

    if(state.logroType == LogroType.rRes){
      //Form not validated
      if(state.status != FormStatus.validated) return;
      yield state.copyWith(description: 'Racha de ${state.numberOfAnswers} respuestas correctas consecutivas en cualquier tema en la máxima dificultad');

      //Submission in progress
      yield state.copyWith(status: FormStatus.submissionInProgress);

      try{
        await _logrosRepository.updateLogroRres(
          LogroModel(
            id          : event.id,
            type            : state.logroType.index,
            name            : state.name,
            description     : state.description,
            numberOfAnswers : state.numberOfAnswers,
          )
        );

        //Submission was a success 
        yield state.copyWith(status: FormStatus.submissionSuccess);

      } on Exception{

        //Submission was a failure
        yield state.copyWith(status: FormStatus.submissionFailure);

      }

    }
    if(state.logroType == LogroType.rDia){
      //Form not validated
      if(state.status != FormStatus.validated) return;
      yield state.copyWith(description: 'Racha de ${state.numberOfDays} días consecutivos');

      //Submission in progress
      yield state.copyWith(status: FormStatus.submissionInProgress);

      try{
        await _logrosRepository.updateLogroRdia(
          LogroModel(
            type        : state.logroType.index,
            name        : state.name,
            description : state.description,
            numberOfDays: state.numberOfDays,
          )
        );

        //Submission was a success 
        yield state.copyWith(status: FormStatus.submissionSuccess);

      } on Exception{

        //Submission was a failure
        yield state.copyWith(status: FormStatus.submissionFailure);

      }

    }
    if(state.logroType == LogroType.eRes){
      //Form not validated
      if(state.status != FormStatus.validated) return;
      yield state.copyWith(description: 'Realiza ${state.numberOfExercises} ejercicios de cualquier tema');

      //Submission in progress
      yield state.copyWith(status: FormStatus.submissionInProgress);

      try{
        await _logrosRepository.updateLogroEres(
          LogroModel(
            type              : state.logroType.index,
            name              : state.name,
            description       : state.description,
            numberOfExercises : state.numberOfExercises,
          )
        );

        //Submission was a success 
        yield state.copyWith(status: FormStatus.submissionSuccess);

      } on Exception{

        //Submission was a failure
        yield state.copyWith(status: FormStatus.submissionFailure);

      }

    }
    if(state.logroType == LogroType.lead){
      //Form not validated
      if(state.status != FormStatus.validated) return;
      yield state.copyWith(description: 'Consigue una puntación dentro de un leaderboard');

      //Submission in progress
      yield state.copyWith(status: FormStatus.submissionInProgress);

      try{
        await _logrosRepository.updateLogroLead(
          LogroModel(
            type        : state.logroType.index,
            name        : state.name,
            description : state.description,
            subject     : state.subject,
          )
        );

        //Submission was a success 
        yield state.copyWith(status: FormStatus.submissionSuccess);

      } on Exception{

        //Submission was a failure
        yield state.copyWith(status: FormStatus.submissionFailure);

      }

    }
  }

}
