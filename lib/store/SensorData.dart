import 'package:sensors/sensors.dart';
//import 'package:mobx/mobx.dart';
//
//part 'SensorData.g.dart';
//
//class SensorData = _SensorData with _$SensorData;
//
//abstract class _SensorData implements Store {
//  //@observable
//  double x, y, z;
//
//  //@observable
//  int measurements = 0;
//
//  //@observable
//  bool listening = false;
//
//  //@action
//
//
//  //@action
//
//}

double x, y, z;
int measurements = 0;
bool listening = false;

void startListening() {
  if (!listening) {
    listening = true;
    // accelerometerEvents.listen(handleAccelerometerEvent);
    accelerometerEvents.listen(handleAccelerometerEvent);

  }
}

handleAccelerometerEvent(AccelerometerEvent event) {
  //x = event.x;
  //y = event.y;
  //z = event.z;
  measurements++;
  //print("lol");
  if (measurements % 50 == 0) {
    print(measurements.toString());
  }
}