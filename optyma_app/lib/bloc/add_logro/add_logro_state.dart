part of 'add_logro_bloc.dart';

abstract class AddLogroState extends Equatable {
  const AddLogroState();
  
  @override
  List<Object> get props => [];
}

class AddLogroInitial extends AddLogroState {}
//TODO: I need to add the attributes for each type of logro  
class AddLogroType1InProgress extends AddLogroState {}

class AddLogroType2InProgress extends AddLogroState {}

class AddLogroType3InProgress extends AddLogroState {}

class AddLogroType4InProgress extends AddLogroState {}

class AddLogroType5InProgress extends AddLogroState {}
