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

class UpdatePlantillaFormSubmitted extends AddPlantillaEvent{
  final String id;

  UpdatePlantillaFormSubmitted(this.id);

  @override
  List<Object> get props => super.props;
}