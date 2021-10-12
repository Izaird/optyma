import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:optyma_app/domain/expressions/expression.dart';
import 'package:optyma_app/domain/expressions/i_expression_facade.dart';

part 'endless_mode_event.dart';
part 'endless_mode_state.dart';
part 'endless_mode_bloc.freezed.dart';

@injectable
class EndlessModeBloc extends Bloc<EndlessModeEvent, EndlessModeState> {
  final IExpressionFacade _expressionFacade;

  EndlessModeBloc(this._expressionFacade) : super(EndlessModeState.initial());

  @override
  Stream<EndlessModeState> mapEventToState( EndlessModeEvent event,) async* {
    yield* event.map(
      started: (e) async*{
        yield state.copyWith(
          operationType: e.operationType,
          difficulty: e.difficulty,
          question: _expressionFacade.questionInt(e.operationType, e.difficulty),
        );
      },

      gameOver: (e) async*{
        int _streak = state.streak;
        int _score = state.score;
        bool _gameOver = true;

        yield state.copyWith(
          streak: _streak,
          score: _score,
          gameOver: _gameOver,
        );
      },

      answerSelected: (e) async*{
        int _streak = state.streak;
        int _score = state.score;
        int _lifes = state.lifes;
        bool _gameOver = false;
        final bool _questionHasCorrectAnswer = e.answer == state.question.result;

        if(_questionHasCorrectAnswer){
          _streak += 1;
          _score += (e.duration~/e.time)*1000;

          yield state.copyWith(
            selectedAnswer: e.answer,
            answered: true,
            streak: _streak,
            score: _score,
          );

          yield await Future.delayed(const Duration(seconds: 2), (){
            return state.copyWith(
              question: _expressionFacade.questionInt(state.operationType, state.difficulty),
              answered: false,
            );
          });

        }else{
          _streak = 0;
          if(_lifes > 1){
            _lifes -= 1;
          }else{
            _lifes = 0;
            _gameOver = true;
          }

          yield state.copyWith(
            lifes: _lifes,
            selectedAnswer: e.answer,
            answered: true,
            streak: _streak,
            score: _score,
          );


          yield await Future.delayed(const Duration(seconds: 2), (){
            return state.copyWith(
              question: _expressionFacade.questionInt(state.operationType, state.difficulty),
              answered: false,
              gameOver: _gameOver,
            );
          });
        }
      },


      timeOver: (e) async*{
        int _lifes = state.lifes;
        bool _gameOver = state.gameOver;
        if(_lifes > 1){
          _lifes -= 1;
        }else{
          _lifes = 0;
          _gameOver = true;
        }


        yield state.copyWith(
          lifes: _lifes,
          selectedAnswer: null,
          answered: true,
          streak: 0,
        );

        yield await Future.delayed(const Duration(seconds: 2), (){
          return state.copyWith(
            question: _expressionFacade.questionInt(state.operationType, state.difficulty),
            answered: false,
            gameOver: _gameOver,
          );
        });

      }, 
    );
  }
}
