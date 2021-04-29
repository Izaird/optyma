part of 'plantillas_bloc.dart';

abstract class PlantillasState extends Equatable {
  const PlantillasState();
  
  @override
  List<Object> get props => [];
}

class PlantillasLoadInProgress extends PlantillasState{}

class PlantillasLoadSuccess extends PlantillasState{
  final List<PlantillaModel> plantillas;
  
  PlantillasLoadSuccess(this.plantillas);

  @override
  List<Object> get props => [plantillas];
}

class PlantillasLoadFailure extends PlantillasState{}
