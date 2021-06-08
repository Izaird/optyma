import 'dart:async';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optyma_app/models/question_model.dart';
import 'package:optyma_app/repository/questions_repository.dart';
part 'quiz_event.dart';
part 'quiz_state.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  QuizBloc({@required QuestionsRepository questionsRepository}) : 
  assert(questionsRepository != null),
  _questionsRepository = questionsRepository,
  super(QuizUninitialized());
  
  final QuestionsRepository _questionsRepository;
  
  @override
  Stream<QuizState> mapEventToState( QuizEvent event,) async* {
    if(event is QuizStarted){
      yield* _mapQuizInitializedToState(event);
    }
  }

  Stream<QuizState> _mapQuizInitializedToState(QuizStarted event) async*{
    yield(
      QuizInitialized(
        questions: await _questionsRepository.getQuestionsArit(difficulty: 1, numberOfQuestions: 5),
        score: 0,
        streak: 0,
      )
    );
  }
}
