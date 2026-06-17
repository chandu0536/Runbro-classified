abstract class LocationEvent {
  const LocationEvent();
}

class SelectLocationEvent extends LocationEvent {
  final String location;
  const SelectLocationEvent(this.location);
}
