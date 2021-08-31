import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'endless_quiz_event.dart';
part 'endless_quiz_state.dart';
part 'endless_quiz_bloc.freezed.dart';

class EndlessQuizBloc extends Bloc<EndlessQuizEvent, EndlessQuizState> {
  EndlessQuizBloc() : super(_Initial());

  @override
  Stream<EndlessQuizState> mapEventToState(
    EndlessQuizEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
