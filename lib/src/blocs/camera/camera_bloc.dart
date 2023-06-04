

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nombre_del_proyecto/src/blocs/camera/camera_event.dart';
import 'package:nombre_del_proyecto/src/blocs/camera/camera_state.dart';

class CameraBloc extends Bloc<CameraEvent,CameraState> {
  CameraBloc(
    CameraState initialState,
  ): super(initialState){
    on<CameraViewEvent>(_cameraViewEvent);
  } 

  void _cameraViewEvent(
    CameraViewEvent event, Emitter<CameraState> emit){
       emit(CameraViewState());
    }
}

