part of 'plantillas_list_bloc.dart';

abstract class PlantillasListEvent extends Equatable {
  const PlantillasListEvent();

  @override
  List<Object> get props => [];
}

class PlantillasListAritSelected extends PlantillasListEvent {}

class PlantillasListAlgeSelected extends PlantillasListEvent {}

class PlantillasListDifeSelected extends PlantillasListEvent {}

class PlantillasListOptiSelected extends PlantillasListEvent {}

class PlantillasListLoaded extends PlantillasListEvent {}

class PlantillasListUpdated extends PlantillasListEvent {
  final List<PlantillaModel> plantillas;
  PlantillasListUpdated(this.plantillas);

  @override
  List<Object> get props => [plantillas];
}