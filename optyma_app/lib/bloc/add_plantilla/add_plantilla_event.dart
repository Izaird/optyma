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

class AddPlantillaNameChanged extends AddPlantillaEvent{
  final String name;
  AddPlantillaNameChanged(this.name); 

  @override
  List<Object> get props => [name];
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

class UpdatePlantillaFormSubmitted extends AddPlantillaEvent{
  final String id;

  UpdatePlantillaFormSubmitted(this.id);

  @override
  List<Object> get props => super.props;
}