part of 'plantillas_bloc.dart';

abstract class PlantillasEvent extends Equatable {
  const PlantillasEvent();

  @override
  List<Object> get props => [];
}


class PlantillasLoaded extends PlantillasEvent{}

class PlantillasUpdated extends PlantillasEvent{
  final List<PlantillaModel> plantillas;

  PlantillasUpdated(this.plantillas);

  @override
  List<Object> get props => [plantillas];
}

