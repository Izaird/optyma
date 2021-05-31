import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:optyma_app/bloc/add_logro/add_logro_bloc.dart';
import 'package:optyma_app/models/plantilla_model.dart';
import 'package:optyma_app/repository/plantillas_repository.dart';
import 'package:optyma_app/utils/constants.dart';

part 'add_plantilla_event.dart';
part 'add_plantilla_state.dart';

class AddPlantillaBloc extends Bloc<AddPlantillaEvent, AddPlantillaState> {
  AddPlantillaBloc({@required PlantillasRepository plantillasRepository})
  : assert(plantillasRepository !=null),
  _plantillasRepository = plantillasRepository,
  super(AddPlantillaState());

  final PlantillasRepository _plantillasRepository;
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
    if(event is AddLogroFormValidated){
      yield state.copyWith(status: FormStatus.validated);
    }
    if(event is AddLogroFormSubmitted){
      yield* _mapAddLogroFormSubmittedToState();
    }
    if(event is UpdatePlantillaFormSubmitted){
      yield* _mapUpdateLogroFormSubmittedToState();
    }
  }

  Stream<AddPlantillaState> _mapAddLogroFormSubmittedToState() async* {
    if(state.subject == 1){
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
          )
        );

        yield state.copyWith(status: FormStatus.submissionSuccess);

      } on Exception{
        //Submission was a failure
        yield state.copyWith(status: FormStatus.submissionFailure);
      }

    }
    if(state.subject == 2){

    }
    if(state.subject == 3){

    }
    if(state.subject == 4){

    }
  }

  Stream<AddPlantillaState> _mapUpdateLogroFormSubmittedToState() async* {

  }

}
