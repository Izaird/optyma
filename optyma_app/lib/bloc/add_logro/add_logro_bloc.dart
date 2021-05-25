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
  }

  Stream<AddLogroState> _mapAddLogroType1SelectedToState() async *{
    yield AddLogroType1InPRogress();
  }

  Stream<AddLogroState> _mapAddLogroType2SelectedToState() async *{
    yield AddLogroType2InPRogress();
  }

  Stream<AddLogroState> _mapAddLogroType3SelectedToState() async *{
    yield AddLogroType3InPRogress();
  }

  Stream<AddLogroState> _mapAddLogroType4SelectedToState() async *{
    yield AddLogroType4InPRogress();
  }

  Stream<AddLogroState> _mapAddLogroType5SelectedToState() async *{
    yield AddLogroType5InPRogress();
  }

}
