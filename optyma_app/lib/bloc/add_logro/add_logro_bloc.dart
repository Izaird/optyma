import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'add_logro_event.dart';
part 'add_logro_state.dart';

class AddLogroBloc extends Bloc<AddLogroEvent, AddLogroState> {
  AddLogroBloc() : super(AddLogroInitial());

  @override
  Stream<AddLogroState> mapEventToState(AddLogroEvent event) async* {

    if(event is AddLogroType1Selected){
      yield* _mapAddLogroType1SelectedToState();
    }
    if(event is AddLogroType2Selected){
      yield* _mapAddLogroType2SelectedToState();
    }
    if(event is AddLogroType3Selected){
      yield* _mapAddLogroType3SelectedToState();
    }
    if(event is AddLogroType4Selected){
      yield* _mapAddLogroType4SelectedToState();
    }
    if(event is AddLogroType5Selected){
      yield* _mapAddLogroType5SelectedToState();
    }
    if(event is AddLogroFormSubmitted){
      yield* _mapAddLogroFormSubmittedToState();
    }
  }

  Stream<AddLogroState> _mapAddLogroType1SelectedToState() async *{
    yield AddLogroType1InProgress();
  }

  Stream<AddLogroState> _mapAddLogroType2SelectedToState() async *{
    yield AddLogroType2InProgress();
  }

  Stream<AddLogroState> _mapAddLogroType3SelectedToState() async *{
    yield AddLogroType3InProgress();
  }

  Stream<AddLogroState> _mapAddLogroType4SelectedToState() async *{
    yield AddLogroType4InProgress();
  }

  Stream<AddLogroState> _mapAddLogroType5SelectedToState() async *{
    yield AddLogroType5InProgress();
  }

  Stream<AddLogroState> _mapAddLogroFormSubmittedToState() async *{
    if(state is AddLogroType1InProgress){
      print('enviando logro 1');
    }
    if(state is AddLogroType2InProgress){
      print('enviando logro 2');
    }
  }

}
