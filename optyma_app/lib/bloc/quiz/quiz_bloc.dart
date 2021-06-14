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
  super(QuizState());
  
  final QuestionsRepository _questionsRepository;
  
  @override
  Stream<QuizState> mapEventToState( QuizEvent event,) async* {
    if(event is QuizStarted){
      yield* _mapQuizInitializedToState(event);
    }
    if(event is QuizAnswerSelected){
      yield* _mapQuizAnswerSelectedToState(event);
    }
    if(event is QuizTimeOver){
      yield* _mapQuizTimeOverToState();
    }
  }

  Stream<QuizState> _mapQuizInitializedToState(QuizStarted event) async*{
    state.copyWith(status: QuizStatus.loading);
    try {
      yield state.copyWith(
        questions: await _questionsRepository.getQuestionsArit(difficulty: 1, numberOfQuestions: 5),
        numberOfQuestions: 5,
        status: QuizStatus.waitingAnswer,
      );
    } catch (e) {
      yield state.copyWith(
        status: QuizStatus.error,
      );
    }
  }

  Stream<QuizState> _mapQuizAnswerSelectedToState(QuizAnswerSelected event) async*{
    int _streak;
    double _score=state.score.toDouble();
    if(state.currentIndex < state.numberOfQuestions - 1){
      //Answer is correct
      if(event.answer == state.questions[state.currentIndex].correctAnswer){
        _streak = state.streak + 1;
        _score = _score + (event.duration/event.time)*1000;
      }else{
      //Wrong answer
        _streak = 0;
      }

      yield state.copyWith(
        selectedAnswer: event.answer, 
        status: QuizStatus.answered,
        streak: _streak,
        score: _score.round()
      );


      yield await Future.delayed(Duration(seconds: 2), (){
        return state.copyWith(
          currentIndex: state.currentIndex + 1, 
          status: QuizStatus.waitingAnswer
        );
      });
    }
    else{
      //Answer is correct
      if(event.answer == state.questions[state.currentIndex].correctAnswer){
        _streak = state.streak + 1;
        _score = _score + (event.duration/event.time)*1000;
        
      }else{
      //Wrong answer
        _streak = 0;
      }

      yield state.copyWith(
        selectedAnswer: event.answer, 
        status: QuizStatus.answered,
        streak: _streak,
        score: _score.round()
      );


      yield await Future.delayed(Duration(seconds: 2), (){
        return state.copyWith(
          status: QuizStatus.completed
        );
      });
    }

  }

  Stream<QuizState> _mapQuizTimeOverToState() async*{
    if(state.currentIndex < state.numberOfQuestions - 1){

      yield state.copyWith(
        selectedAnswer: null, 
        status: QuizStatus.answered,
        streak: 0,
      );

      yield await Future.delayed(Duration(seconds: 2), (){
        return state.copyWith(
          currentIndex: state.currentIndex + 1, 
          status: QuizStatus.waitingAnswer
        );
      });
    }
    else{
      yield state.copyWith(
        selectedAnswer: null, 
        status: QuizStatus.answered,
        streak: 0,
      );

      yield await Future.delayed(Duration(seconds: 2), (){
        return state.copyWith(
          status: QuizStatus.completed
        );
      });
    }
  }

}
