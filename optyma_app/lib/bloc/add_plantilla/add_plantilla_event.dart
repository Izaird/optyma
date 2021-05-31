part of 'add_plantilla_bloc.dart';

abstract class AddPlantillaEvent extends Equatable {
  const AddPlantillaEvent();

  @override
  List<Object> get props => [];
}

class AddPlantillaType1Selected extends AddPlantillaEvent{}

class AddPlantillaType2Selected extends AddPlantillaEvent{}

class AddPlantillaType3Selected extends AddPlantillaEvent{}

class AddPlantillaType4Selected extends AddPlantillaEvent{}

class AddPlantillaFormValidated extends AddPlantillaEvent{}

class AddPlantillaFormSubmitted extends AddPlantillaEvent{}

class AddPlantillaSentenceChanged extends AddPlantillaEvent{
  final String sentence;
  AddPlantillaSentenceChanged(this.sentence); 

  @override
  List<Object> get props => [sentence];
}

class AddPlantillaExpressionChanged extends AddPlantillaEvent{
  final String expression;
  AddPlantillaExpressionChanged(this.expression); 

  @override
  List<Object> get props => [expression];
}

class AddPlantillaDifficultyChanged extends AddPlantillaEvent{
  final int difficulty;
  AddPlantillaDifficultyChanged(this.difficulty); 

  @override
  List<Object> get props => [difficulty];
}

class AddPlantillaSubjectChanged extends AddPlantillaEvent{
  final int subject;
  AddPlantillaSubjectChanged(this.subject); 

  @override
  List<Object> get props => [subject];
}
class AddPlantillaTimeOpenChanged extends AddPlantillaEvent{
  final int timeOpen;
  AddPlantillaTimeOpenChanged(this.timeOpen); 

  @override
  List<Object> get props => [timeOpen];
}
class AddPlantillaTimeCloseChanged extends AddPlantillaEvent{
  final int timeClose;
  AddPlantillaTimeCloseChanged(this.timeClose); 

  @override
  List<Object> get props => [timeClose];
}
class UpdatePlantillaFormSubmitted extends AddPlantillaEvent{
  final String id;

  UpdatePlantillaFormSubmitted(this.id);

  @override
  List<Object> get props => super.props;
}