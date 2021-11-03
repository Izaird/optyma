import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:optyma_app/domain/expressions/expression.dart';
import 'package:optyma_app/domain/expressions/i_expression_facade.dart';

part 'pvp_mode_event.dart';
part 'pvp_mode_state.dart';
part 'pvp_mode_bloc.freezed.dart';

@injectable
class PvpModeBloc extends Bloc<PvpModeEvent, PvpModeState> {
  final IExpressionFacade _expressionFacade;

  PvpModeBloc(this._expressionFacade) : super(PvpModeState.initial());
  
  @override
  Stream<PvpModeState> mapEventToState(PvpModeEvent event) async*{
    yield* event.map(
      started: (e) async*{
        yield state.copyWith(
          operationType: e.operationType,
          difficulty: e.difficulty,
          question: _expressionFacade.questionInt(e.operationType, e.difficulty),
        );
      },

    gameOver: (e) async*{
        int _score1 = state.score1;
        bool _gameOver = true;

        yield state.copyWith(
          score1: _score1,
          gameOver: _gameOver,
        );
        
    },

    answer1Selected: (e) async*{
      int _nquestions = state.nquestions;
      int _score1 = state.score1;
      bool _gameOver = false;
      bool _answered1 = true;
      bool _answered2 = state.answeredj2;
      final bool _questionHasCorrectAnswer = e.answer == state.question.result;

      if(_nquestions<=1 ){
        _gameOver=true;
      }
      if(_questionHasCorrectAnswer){
        _nquestions=_nquestions-1;
        if(state.difficulty==Difficulty.easy){
            _score1 += ((e.duration/e.time)*500).round();
          }
          else if(state.difficulty==Difficulty.medium){
            _score1 += ((e.duration/e.time)*1000).round();
          }
          else if(state.difficulty==Difficulty.hard){
            _score1 += ((e.duration/e.time)*2000).round();
          }
        yield state.copyWith(
          selectedAnswer: e.answer,
          answered: true,
          score1: _score1,
          nquestions: _nquestions,
          gameOver: _gameOver,
        );
        yield await Future.delayed(const Duration(seconds: 2), (){
          return state.copyWith(
            question: _expressionFacade.questionInt(state.operationType, state.difficulty),
            answered: false,
            answeredj2: false,
          );
        });
      }else{
        yield state.copyWith(
            selectedAnswer: e.answer,
            answered: true,
            score1: _score1,
            nquestions: _nquestions,
            gameOver: _gameOver,
          );

          if(_answered1 && _answered2){
            _nquestions=_nquestions-1;
            yield await Future.delayed(const Duration(seconds: 2), (){
              return state.copyWith(
                question: _expressionFacade.questionInt(state.operationType, state.difficulty),
                answered: false,
                answeredj2: false,
                gameOver: _gameOver,
              );
            });
          }
            
      }        
    },

    answer2Selected: (e) async*{
      int _nquestions = state.nquestions;
      int _score2 = state.score2;
      bool _gameOver = false;
      bool _answered1 = state.answered;
      bool _answered2 = true;
      final bool _questionHasCorrectAnswer = e.answer == state.question.result;

      if(_nquestions<=1){
        _gameOver=true;
      }
      if(_questionHasCorrectAnswer){
        _nquestions=_nquestions-1;
        if(state.difficulty==Difficulty.easy){
            _score2 += ((e.duration/e.time)*500).round();
          }
          else if(state.difficulty==Difficulty.medium){
            _score2 += ((e.duration/e.time)*1000).round();
          }
          else if(state.difficulty==Difficulty.hard){
            _score2 += ((e.duration/e.time)*2000).round();
          }
        yield state.copyWith(
          selectedAnswerj2: e.answer,
          answeredj2: true,
          score2: _score2,
          nquestions: _nquestions,
          gameOver: _gameOver,
        );
        yield await Future.delayed(const Duration(seconds: 2), (){
          return state.copyWith(
            question: _expressionFacade.questionInt(state.operationType, state.difficulty),
            answered: false,
            answeredj2: false,
          );
        });
      }else{
        yield state.copyWith(
            selectedAnswerj2: e.answer,
            answeredj2: true,
            score2: _score2,
            nquestions: _nquestions
          );

          if(_answered1 && _answered2){
            _nquestions=_nquestions-1;
            yield await Future.delayed(const Duration(seconds: 2), (){
              return state.copyWith(
                question: _expressionFacade.questionInt(state.operationType, state.difficulty),
                answered: false,
                answeredj2: false,
                gameOver: _gameOver,
              );
            });
          }
      }        
    },

    timeOver: (e) async*{
      bool _gameOver = state.gameOver;
      yield state.copyWith(
        gameOver: _gameOver
      );
      yield await Future.delayed(const Duration(seconds: 2), (){
        return state.copyWith(
          question: _expressionFacade.questionInt(state.operationType, state.difficulty),
          answered: false,
          answeredj2: false,
          gameOver: _gameOver,
        );
      });
    }
    );//yield event map
  }

}
