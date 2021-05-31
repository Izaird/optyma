part of 'plantillas_list_bloc.dart';

abstract class PlantillasListState extends Equatable {
  const PlantillasListState();
  
  @override
  List<Object> get props => [];
}

class PlantillasListInitial extends PlantillasListState {}

class PlantillasListArit extends PlantillasListState {}

class PlantillasListAlge extends PlantillasListState {}

class PlantillasListDife extends PlantillasListState {}

class PlantillasListOpti extends PlantillasListState {}

class PlantillasListLoadInProgress extends PlantillasListState {}

class PlantillasListLoadSuccess extends PlantillasListState {
  final List<PlantillaModel> plantillas;
  PlantillasListLoadSuccess(this.plantillas);

  @override
  List<Object> get props => [plantillas];
}

class PlantillasListLoadFailure extends PlantillasListState {}
