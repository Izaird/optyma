import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:optyma_app/models/logro_model.dart';
import 'package:optyma_app/repository/logros_repository.dart';

part 'logro_state.dart';

class LogroCubit extends Cubit<LogroState> {
  LogroCubit(this._logrosRepository) : super(LogroState());

  final LogrosRepository _logrosRepository;

  void nameChanged(String name){
    emit(state.copyWith(
      name  : name,
    ));
  }

  void descriptionChanged(String description){
    emit(state.copyWith(
      description  : description,
    ));
  }

  void validated(){
    emit(state.copyWith(
      status: 1,
    ));
  }

  Future<void> addLogroFormSubmitted() async{
    //Status is not validated
    if(state.status != 1) return;
    //Submission in progress
    emit(state.copyWith(status: 2));

    try {
      await _logrosRepository.addLogro(LogroModel(
        name: state.name,
        description: state.description
      ));
      //Submission was a success
      emit(state.copyWith(status:3));
    } on Exception{
      //Submission was a failure
      emit(state.copyWith(status:4));
    }
  }

  Future<void> updateLogroFormSubmitted(String id) async{
    //Status is not validated
    if(state.status != 1) return;
    //Submission in progress
    emit(state.copyWith(status: 2));

    try {
      await _logrosRepository.updateLogroData(LogroModel(
        name: state.name,
        description: state.description,
        id: id
      ));
      //Submission was a success
      emit(state.copyWith(status:3));
    } on Exception{
      //Submission was a failure
      emit(state.copyWith(status:4));
    }
  }
}
