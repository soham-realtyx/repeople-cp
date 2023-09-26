

import 'package:event_bus/event_bus.dart';

EventBus eventBus = EventBus();

class InternetConnectionChanged {
  final bool status;
  InternetConnectionChanged({required this.status});
}