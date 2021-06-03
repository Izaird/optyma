import 'dart:async';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optyma_app/repository/plantillas_repository.dart';
import 'package:optyma_app/models/plantilla_model.dart';
part 'quiz_event.dart';
part 'quiz_state.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  QuizBloc({@required PlantillasRepository plantillasRepository}) : 
  assert(plantillasRepository != null),
  _plantillasRepository = plantillasRepository,
  super(QuizUninitialized());
  
  final PlantillasRepository _plantillasRepository;
  int score;
  int streak;
  
  @override
  Stream<QuizState> mapEventToState( QuizEvent event,) async* {
    if(event is QuizStarted){
      yield* _mapQuizInitializedToState(event);
    }
  }

  Stream<QuizState> _mapQuizInitializedToState(QuizStarted event) async*{
    yield QuizInitialized(
      plantillas: await _plantillasRepository.getPlantillasByDifAndSubj(
        difficulty: event.difficulty,
        subject: event.subject 
      ),
    );
  }
}
