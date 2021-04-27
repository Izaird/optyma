import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optyma_app/models/plantilla_model.dart';
import 'package:optyma_app/repository/authentication_repository.dart';
import 'package:optyma_app/repository/cloud_firestore_repository.dart';

part 'plantilla_state.dart';

class PlantillaCubit extends Cubit<PlantillaState> {
  PlantillaCubit({
    @required AuthenticationRepository authenticationRepository,
    @required CloudFirestoreRepository cloudFirestoreRepository,
    })
    : assert(authenticationRepository != null),
      assert(cloudFirestoreRepository != null),
      _authenticationRepository = authenticationRepository,
      _cloudFirestoreRepository = cloudFirestoreRepository,
     super(PlantillaState());

  final CloudFirestoreRepository _cloudFirestoreRepository;
  final AuthenticationRepository _authenticationRepository;

  void difficultyChanged(int difficulty){
    emit(state.copyWith(
      difficulty  : difficulty,
    ));
  }

  void expChanged(String exp){
    emit(state.copyWith(
      exp  : exp,
    ));
  }

  void sentenceChanged(String sentence){
    emit(state.copyWith(
      sentence  : sentence,
    ));
  }

  void subjectChanged(String subject){
    emit(state.copyWith(
      subject  : subject,
    ));
  }

  void time1Changed(int time1){
    emit(state.copyWith(
      time1  : time1,
    ));
  }

  void time2Changed(int time2){
    emit(state.copyWith(
      time2  : time2,
    ));
  }

  void validated(){
    emit(state.copyWith(
      status: 1,
    ));
  }

  Future<void> plantillaFormSubmitted() async{
    //Status is not validated
    if(state.status != 1) return;
    //Submission in progress
    emit(state.copyWith(status: 2));

    try {
      await _cloudFirestoreRepository.addPlantilla(PlantillaModel(
        dificultad    : state.difficulty,
        exp           : state.exp,
        sentencia     : state.sentence,
        tema          : state.subject,
        tiempoAbierta : state.time1,
        tiempoCerrada : state.time2,
        uid           : _authenticationRepository.getUser().uid,
        timestamp     : DateTime.now(),
      ));
      //Submission was a success
      emit(state.copyWith(status:3));
    } on Exception{
      //Submission was a failure
      emit(state.copyWith(status:4));
    }
  }
}
