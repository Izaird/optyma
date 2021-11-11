import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:optyma_app/application/templates/template_form/template_form_bloc.dart';
import 'package:optyma_app/domain/expressions/expression.dart';
import 'package:optyma_app/domain/expressions/i_expression_facade.dart';
import 'package:optyma_app/domain/templates/i_template_repository.dart';
import 'package:optyma_app/domain/templates/template.dart';
import 'package:optyma_app/domain/templates/template_failure.dart';

part 'classic_mode_event.dart';
part 'classic_mode_state.dart';
part 'classic_mode_bloc.freezed.dart';

@injectable
class ClassicModeBloc extends Bloc<ClassicModeEvent, ClassicModeState> {
  final IExpressionFacade _expressionFacade;
  final ITemplateRepository _templateRepository;
  ClassicModeBloc(this._expressionFacade, this._templateRepository) : super(ClassicModeState.initial());
  //ClassicModeBloc(this._expressionFacade) : super(ClassicModeState.initial());
  @override
  Stream<ClassicModeState> mapEventToState( ClassicModeEvent event,) async* {
    yield* event.map(

      started: (e) async*{
        final failOrTemplate = await _templateRepository.getAllTemplates();
        
        yield state.copyWith(
          operationType: e.operationType,
          difficulty: e.difficulty,
          question: await _expressionFacade.questionInt(e.operationType, e.difficulty),
          //templates: failOrTemplate.fold((l) => [] , (r) => r )
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
        int _nquest = state.nquestions;
        bool _gameOver = false;
        final bool _questionHasCorrectAnswer = e.answer == state.question.result;

        if(_questionHasCorrectAnswer){
          _streak += 1;
          _nquest -= 1;
          if(_nquest<=0){
            _gameOver=true;
          }
          if(state.difficulty==Difficulty.easy){
            _score += ((e.duration/30)*500).round();
          }
          else if(state.difficulty==Difficulty.medium){
            _score += ((e.duration/45)*1000).round();
          }
          else if(state.difficulty==Difficulty.hard){
            _score += ((e.duration/60)*2000).round();
          }
          

          yield state.copyWith(
            selectedAnswer: e.answer,
            answered: true,
            streak: _streak,
            score: _score,
            nquestions: _nquest,
            gameOver: _gameOver
          );

          yield await Future.delayed(const Duration(seconds: 2), ()async{
            return state.copyWith(
              question: await _expressionFacade.questionInt(state.operationType, state.difficulty),
              answered: false,
            );
          });

        }else{
          _streak = 0;
          if(_nquest > 1){
            _nquest -= 1;
          }else{
            _nquest = 0;
            _gameOver = true;
          }

          yield state.copyWith(
            nquestions: _nquest,
            selectedAnswer: e.answer,
            answered: true,
            streak: _streak,
            score: _score,
          );


          yield await Future.delayed(const Duration(seconds: 2), ()async{
            return state.copyWith(
              question: await _expressionFacade.questionInt(state.operationType, state.difficulty),
              answered: false,
              gameOver: _gameOver,
            );
          });
        }
      },


      timeOver: (e) async*{
        int _lifes = state.nquestions;
        bool _gameOver = state.gameOver;
        if(_lifes > 1){
          _lifes -= 1;
        }else{
          _lifes = 0;
          _gameOver = true;
        }


        yield state.copyWith(
          nquestions: _lifes,
          selectedAnswer: null,
          answered: true,
          streak: 0,
        );

        yield await Future.delayed(const Duration(seconds: 2), ()async{
          return state.copyWith(
            question: await _expressionFacade.questionInt(state.operationType, state.difficulty),
            answered: false,
            gameOver: _gameOver,
          );
        });

      }, 
    );
  }
}

