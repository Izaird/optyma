import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:optyma_app/domain/expressions/expression.dart';
import 'package:optyma_app/domain/expressions/i_expression_facade.dart';

part 'endless_mode_event.dart';
part 'endless_mode_state.dart';
part 'endless_mode_bloc.freezed.dart';

class EndlessModeBloc extends Bloc<EndlessModeEvent, EndlessModeState> {
  final IExpressionFacade _expressionFacade;

  EndlessModeBloc(this._expressionFacade) : super(EndlessModeState.initial());

  @override
  Stream<EndlessModeState> mapEventToState( EndlessModeEvent event,) async* {
    yield* event.map(
      started: (e) async*{
      }, 

      answerSelected: (e) async*{

      }, 

      nextQuestion: (e) async*{
      }, 

      ended: (e) async*{

      }, 
    );
  }
}
