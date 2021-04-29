import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:optyma_app/models/plantilla_model.dart';
import 'package:optyma_app/repository/plantillas_repository.dart';

part 'plantillas_event.dart';
part 'plantillas_state.dart';

class PlantillasBloc extends Bloc<PlantillasEvent, PlantillasState> {

  final PlantillasRepository _plantillasRepository;
  StreamSubscription _plantillasSubscription;

  PlantillasBloc({@required PlantillasRepository plantillasRepository})
    : assert(plantillasRepository != null),
    _plantillasRepository = plantillasRepository,
    super(PlantillasLoadInProgress());

  @override
  Stream<PlantillasState> mapEventToState(PlantillasEvent event,) async* {
    if(event is PlantillasLoaded){
      yield* _mapLogrosLoadToState();
    }
    if(event is PlantillasUpdated){
      yield * _mapLogrosUpdateToState(event);
    }
  }


  Stream<PlantillasState> _mapLogrosLoadToState() async *{
    yield PlantillasLoadInProgress();
    _plantillasSubscription?.cancel();
    try {
      _plantillasSubscription = _plantillasRepository.getPlantillas().listen((plantillas) {
        add(PlantillasUpdated(plantillas));
       });
      // final List<LogroModel> plantillas = await _plantillasRepository.getLogros().first;
      // yield PlantillasLoaded(plantillas);
    }
    catch (_) {
      yield PlantillasLoadFailure();
    }
  }

  Stream<PlantillasState> _mapLogrosUpdateToState(PlantillasUpdated event) async *{
    yield PlantillasLoadSuccess(event.plantillas);
  }


  @override
  Future<void> close() {
    _plantillasSubscription?.cancel();
    return super.close();
  }
}
