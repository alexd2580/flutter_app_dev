import 'package:scoped_model/scoped_model.dart';
import 'package:sensors/sensors.dart';

class SensorDataModel extends Model {
  double _x, _y, _z;
  int _measurements = 0;
  bool _listening = false;
  void startListening() {
    if(!_listening) {
      _listening = true;
      accelerometerEvents.listen((AccelerometerEvent event) {
        _x = event.x;
        _y = event.y;
        _z = event.z;
        _measurements++;
      });
    } else {
      notifyListeners();
    }
  }

  double get x => _x;
  double get y => _y;
  double get z => _z;
  int get measurements => _measurements;
}