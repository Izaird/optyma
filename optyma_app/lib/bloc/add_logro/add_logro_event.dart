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

class AddLogroFormValidated extends AddLogroEvent{}

class AddLogroFormSubmitted extends AddLogroEvent{}

class UpdateLogroFormSubmitted extends AddLogroEvent{
  final String id;
  UpdateLogroFormSubmitted(this.id);

  @override
  List<Object> get props => [id];
}

class AddLogroNameChanged extends AddLogroEvent{
  final String name;
  AddLogroNameChanged(this.name); 

  @override
  List<Object> get props => [name];
}

class AddLogroDifficultyChanged extends AddLogroEvent{
  final int difficulty;
  AddLogroDifficultyChanged(this.difficulty); 

  @override
  List<Object> get props => [difficulty];
}

class AddLogroSubjectChanged extends AddLogroEvent{
  final int subject;
  AddLogroSubjectChanged(this.subject); 

  @override
  List<Object> get props => [subject];
}

class AddLogroNumberOfDaysChanged extends AddLogroEvent{
  final int numberOfDays;
  AddLogroNumberOfDaysChanged(this.numberOfDays); 

  @override
  List<Object> get props => [numberOfDays];
}

class AddLogroNumberOfExercisesChanged extends AddLogroEvent{
  final int numberOfExercises;
  AddLogroNumberOfExercisesChanged(this.numberOfExercises); 

  @override
  List<Object> get props => [numberOfExercises];
}

class AddLogroNumberOfAnswersChanged extends AddLogroEvent{
  final int numberOfAnswers;
  AddLogroNumberOfAnswersChanged(this.numberOfAnswers); 

  @override
  List<Object> get props => [numberOfAnswers];
}