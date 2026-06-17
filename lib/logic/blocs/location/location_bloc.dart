import 'package:flutter_bloc/flutter_bloc.dart';
import 'location_event.dart';
import 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LocationBloc() : super(const LocationState(selectedLocation: 'Hyderabad, TS')) {
    on<SelectLocationEvent>(_onSelectLocation);
  }

  void _onSelectLocation(SelectLocationEvent event, Emitter<LocationState> emit) {
    emit(LocationState(selectedLocation: event.location));
  }
}
