part of 'add_logro_bloc.dart';

abstract class AddLogroEvent extends Equatable {
  const AddLogroEvent();

  @override
  List<Object> get props => [];
}


class AddLogroType1Selected extends AddLogroEvent{}

class AddLogroType2Selected extends AddLogroEvent{}

class AddLogroType3Selected extends AddLogroEvent{}

class AddLogroType4Selected extends AddLogroEvent{}

class AddLogroType5Selected extends AddLogroEvent{}
