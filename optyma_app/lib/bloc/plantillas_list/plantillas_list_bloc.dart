import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:optyma_app/models/plantilla_model.dart';
import 'package:optyma_app/repository/plantillas_repository.dart';

part 'plantillas_list_event.dart';
part 'plantillas_list_state.dart';

class PlantillasListBloc extends Bloc<PlantillasListEvent, PlantillasListState> {
  final PlantillasRepository _plantillasRepository;
  StreamSubscription _streamSubscription;

  PlantillasListBloc({@required PlantillasRepository plantillasRepository}) 
  : assert(plantillasRepository != null),
    _plantillasRepository = plantillasRepository,
    super(PlantillasListInitial());

  @override
  Stream<PlantillasListState> mapEventToState( PlantillasListEvent event) async* {
    if(event is PlantillasListAritSelected){
      yield* _mapPlantillasListArtiSelectedToState();
    }
    if(event is PlantillasListAlgeSelected){
      yield* _mapPlantillasListAlgeSelectedToState();
    }
    if(event is PlantillasListDifeSelected){
      yield* _mapPlantillasListDifeSelectedToState();
    }
    if(event is PlantillasListOptiSelected){
      yield* _mapPlantillasListOptiSelectedToState();
    }
    if(event is PlantillasListLoaded){
      yield* _mapPlantillasListLoadedToState();
    }
    if(event is PlantillasListUpdated){
      yield* _mapPlantillasListUpdatedToState(event);
    }
  }

  Stream<PlantillasListState> _mapPlantillasListArtiSelectedToState() async *{
    yield PlantillasListArit();
  }

  Stream<PlantillasListState> _mapPlantillasListAlgeSelectedToState() async *{
    yield PlantillasListAlge();
  }

  Stream<PlantillasListState> _mapPlantillasListDifeSelectedToState() async *{
    yield PlantillasListDife();
  }

  Stream<PlantillasListState> _mapPlantillasListOptiSelectedToState() async *{
    yield PlantillasListOpti();
  }

  Stream<PlantillasListState> _mapPlantillasListLoadedToState() async *{
    if(state is PlantillasListArit){
      yield PlantillasListLoadInProgress();
      _streamSubscription?.cancel();
      try{
        _streamSubscription = _plantillasRepository.getPlantillasArit().listen((plantillas) {
          add(PlantillasListUpdated(plantillas));
        });
      }
      catch(_){
        yield PlantillasListLoadFailure();
      }
    }

    if(state is PlantillasListAlge){
      yield PlantillasListLoadInProgress();
      _streamSubscription?.cancel();
      try{
        _streamSubscription = _plantillasRepository.getPlantillasAlge().listen((plantillas) {
          add(PlantillasListUpdated(plantillas));
        });
      }
      catch(_){
        yield PlantillasListLoadFailure();
      }
    }

    if(state is PlantillasListDife){
      yield PlantillasListLoadInProgress();
      _streamSubscription?.cancel();
      try{
        _streamSubscription = _plantillasRepository.getPlantillasDife().listen((plantillas) {
          add(PlantillasListUpdated(plantillas));
        });
      }
      catch(_){
        yield PlantillasListLoadFailure();
      }
    }

    if(state is PlantillasListOpti){
      yield PlantillasListLoadInProgress();
      _streamSubscription?.cancel();
      try{
        _streamSubscription = _plantillasRepository.getPlantillasOpti().listen((plantillas) {
          add(PlantillasListUpdated(plantillas));
        });
      }
      catch(_){
        yield PlantillasListLoadFailure();
      }
    }

  }

  Stream<PlantillasListState> _mapPlantillasListUpdatedToState(PlantillasListUpdated event) async *{
    yield PlantillasListLoadSuccess(event.plantillas);
  }

  @override 
  Future<void> close(){
    _streamSubscription?.cancel();
    return super.close();
  }
}
