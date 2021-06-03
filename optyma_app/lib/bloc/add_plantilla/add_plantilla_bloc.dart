import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:optyma_app/models/plantilla_model.dart';
import 'package:optyma_app/repository/authentication_repository.dart';
import 'package:optyma_app/repository/plantillas_repository.dart';
import 'package:optyma_app/utils/constants.dart';

part 'add_plantilla_event.dart';
part 'add_plantilla_state.dart';

class AddPlantillaBloc extends Bloc<AddPlantillaEvent, AddPlantillaState> {
  AddPlantillaBloc({
    @required PlantillasRepository plantillasRepository,
    @required AuthenticationRepository authenticationRepository,
  })
  : assert(plantillasRepository !=null),
  assert(authenticationRepository !=null),
  _plantillasRepository = plantillasRepository,
  _authenticationRepository = authenticationRepository,
  super(AddPlantillaState());

  final PlantillasRepository _plantillasRepository;
  final AuthenticationRepository _authenticationRepository;
  @override
  Stream<AddPlantillaState> mapEventToState(AddPlantillaEvent event) async* {
    if(event is AddPlantillaType1Selected){
      yield state.copyWith(subject: 1);
    }
    if(event is AddPlantillaType2Selected){
      yield state.copyWith(subject: 2);
    }
    if(event is AddPlantillaType3Selected){
      yield state.copyWith(subject: 3);
    }
    if(event is AddPlantillaType4Selected){
      yield state.copyWith(subject: 4);
    }
    if(event is AddPlantillaFormValidated){
      yield state.copyWith(status: FormStatus.validated);
    }
    if(event is AddPlantillaFormSubmitted){
      yield* _mapAddPlantillaFormSubmittedToState();
    }
    if(event is UpdatePlantillaFormSubmitted){
      yield* _mapUpdatePlantillaFormSubmittedToState(event);
    }
    if(event is AddPlantillaSentenceChanged){
      yield* _mapAddPlantillaSentenceChangedtoState(event);
    }
    if (event is AddPlantillaDifficultyChanged){
      yield* _mapAddPlantillaDifficultyChangedToState(event);
    }
    if(event is AddPlantillaValuesChanged){
      yield state.copyWith(values: event.values);
    }
    if (event is AddPlantillaExpressionChanged){
      yield* _mapAddPlantillaExpressionChangedToState(event);
    }
    if (event is AddPlantillaTimeOpenChanged){
      yield* _mapAddPlantillaTimeOpenChangedToState(event);
    }
    if (event is AddPlantillaTimeCloseChanged){
      yield* _mapAddPlantillaTimeCloseChangedToState(event);
    }
  }
  Stream<AddPlantillaState> _mapAddPlantillaSentenceChangedtoState(AddPlantillaSentenceChanged event) async *{
    yield state.copyWith(sentence: event.sentence);
  }
  Stream<AddPlantillaState> _mapAddPlantillaExpressionChangedToState(AddPlantillaExpressionChanged event) async *{
    yield state.copyWith(expression: event.expression);
  }
  Stream<AddPlantillaState> _mapAddPlantillaDifficultyChangedToState(AddPlantillaDifficultyChanged event) async *{
    yield state.copyWith(difficulty: event.difficulty);
  }
  Stream<AddPlantillaState> _mapAddPlantillaTimeOpenChangedToState(AddPlantillaTimeOpenChanged event) async *{
    yield state.copyWith(timeOpen: event.timeOpen);
  }
  Stream<AddPlantillaState> _mapAddPlantillaTimeCloseChangedToState(AddPlantillaTimeCloseChanged event) async *{
    yield state.copyWith(timeClose: event.timeClose);
  }
  Stream<AddPlantillaState> _mapAddPlantillaFormSubmittedToState() async* {
    if(state.subject == 1){
      if(state.status != FormStatus.validated) return;

      //Submission in progress
      yield state.copyWith(status: FormStatus.submissionInProgress);

      try{
        await _plantillasRepository.addPlantillaArit(
          PlantillaModel(
            difficulty: state.difficulty,
            expression: state.expression,
            sentence  : state.sentence,
            values    : state.values, 
            timeOpen  : state.timeOpen,
            timeClose : state.timeClose,
            subject   : state.subject, 
            uid       : _authenticationRepository.getUser().uid,
          )
        );

        yield state.copyWith(status: FormStatus.submissionSuccess);

      } on Exception{
        //Submission was a failure
        yield state.copyWith(status: FormStatus.submissionFailure);
      }

    }
    if(state.subject == 2){
      if(state.status != FormStatus.validated) return;

      //Submission in progress
      yield state.copyWith(status: FormStatus.submissionInProgress);

      try{
        await _plantillasRepository.addPlantilla(
          PlantillaModel(
            difficulty: state.difficulty,
            expression: state.expression,
            sentence  : state.sentence, 
            timeOpen  : state.timeOpen,
            timeClose : state.timeClose,
            subject   : state.subject, 
            uid       : _authenticationRepository.getUser().uid,
          )
        );

        yield state.copyWith(status: FormStatus.submissionSuccess);

      } on Exception{
        //Submission was a failure
        yield state.copyWith(status: FormStatus.submissionFailure);
      }

    }
    if(state.subject == 3){

      if(state.status != FormStatus.validated) return;

      //Submission in progress
      yield state.copyWith(status: FormStatus.submissionInProgress);

      try{
        await _plantillasRepository.addPlantilla(
          PlantillaModel(
            difficulty: state.difficulty,
            expression: state.expression,
            sentence  : state.sentence, 
            timeOpen  : state.timeOpen,
            timeClose : state.timeClose,
            subject   : state.subject, 
            uid       : _authenticationRepository.getUser().uid,
          )
        );

        yield state.copyWith(status: FormStatus.submissionSuccess);

      } on Exception{
        //Submission was a failure
        yield state.copyWith(status: FormStatus.submissionFailure);
      }
    }
    if(state.subject == 4){

      if(state.status != FormStatus.validated) return;

      //Submission in progress
      yield state.copyWith(status: FormStatus.submissionInProgress);

      try{
        await _plantillasRepository.addPlantilla(
          PlantillaModel(
            difficulty: state.difficulty,
            expression: state.expression,
            sentence  : state.sentence, 
            timeOpen  : state.timeOpen,
            timeClose : state.timeClose,
            subject   : state.subject, 
            uid       : _authenticationRepository.getUser().uid,
          )
        );

        yield state.copyWith(status: FormStatus.submissionSuccess);

      } on Exception{
        //Submission was a failure
        yield state.copyWith(status: FormStatus.submissionFailure);
      }
    }
  }

  Stream<AddPlantillaState> _mapUpdatePlantillaFormSubmittedToState(UpdatePlantillaFormSubmitted event) async* {

    if(state.subject == 1){
      if(state.status != FormStatus.validated) return;

      //Submission in progress
      yield state.copyWith(status: FormStatus.submissionInProgress);

      try{
        await _plantillasRepository.updatePlantillaArit(
          PlantillaModel(
            difficulty: state.difficulty,
            expression: state.expression,
            sentence  : state.sentence, 
            values    : state.values,
            timeOpen  : state.timeOpen,
            timeClose : state.timeClose,
            subject   : state.subject, 
            id        : event.id,
          )
        );

        yield state.copyWith(status: FormStatus.submissionSuccess);

      } on Exception{
        //Submission was a failure
        yield state.copyWith(status: FormStatus.submissionFailure);
      }

    }
    if(state.subject == 2){
      if(state.status != FormStatus.validated) return;

      //Submission in progress
      yield state.copyWith(status: FormStatus.submissionInProgress);

      try{
        await _plantillasRepository.updatePlantilla(
          PlantillaModel(
            difficulty: state.difficulty,
            expression: state.expression,
            sentence  : state.sentence, 
            timeOpen  : state.timeOpen,
            timeClose : state.timeClose,
            subject   : state.subject, 
            id        : event.id,
          )
        );

        yield state.copyWith(status: FormStatus.submissionSuccess);

      } on Exception{
        //Submission was a failure
        yield state.copyWith(status: FormStatus.submissionFailure);
      }

    }
    if(state.subject == 3){

      if(state.status != FormStatus.validated) return;

      //Submission in progress
      yield state.copyWith(status: FormStatus.submissionInProgress);

      try{
        await _plantillasRepository.updatePlantilla(
          PlantillaModel(
            difficulty: state.difficulty,
            expression: state.expression,
            sentence  : state.sentence, 
            timeOpen  : state.timeOpen,
            timeClose : state.timeClose,
            subject   : state.subject, 
            id        : event.id,
          )
        );

        yield state.copyWith(status: FormStatus.submissionSuccess);

      } on Exception{
        //Submission was a failure
        yield state.copyWith(status: FormStatus.submissionFailure);
      }
    }
    if(state.subject == 4){

      if(state.status != FormStatus.validated) return;

      //Submission in progress
      yield state.copyWith(status: FormStatus.submissionInProgress);

      try{
        await _plantillasRepository.updatePlantilla(
          PlantillaModel(
            difficulty: state.difficulty,
            expression: state.expression,
            sentence  : state.sentence, 
            timeOpen  : state.timeOpen,
            timeClose : state.timeClose,
            subject   : state.subject, 
            id        : event.id,
          )
        );

        yield state.copyWith(status: FormStatus.submissionSuccess);

      } on Exception{
        //Submission was a failure
        yield state.copyWith(status: FormStatus.submissionFailure);
      }
    }
  }

}
