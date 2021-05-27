import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:optyma_app/utils/constants.dart';

part 'add_plantilla_event.dart';
part 'add_plantilla_state.dart';

class AddPlantillaBloc extends Bloc<AddPlantillaEvent, AddPlantillaState> {
  AddPlantillaBloc() : super(AddPlantillaState());

  @override
  Stream<AddPlantillaState> mapEventToState(AddPlantillaEvent event) async* {
  }
}
