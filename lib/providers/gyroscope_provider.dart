import 'package:flutter/widgets.dart';
import 'package:sensors/sensors.dart';
import 'dart:async';

class GyroScopeProvider with ChangeNotifier {
  static const double XFACT = 30.0;
  static const double YFACT = 50.0;
  static const double ZFACT = 100.0;
  double _x = 0.0;
  double _y = 0.0;
  double _z = 0.0;

  StreamSubscription<AccelerometerEvent> _streamSubscription;

  GyroScopeProvider() {
    _streamSubscription =
        accelerometerEvents.listen((AccelerometerEvent event) {
      x = event.x.round() / XFACT;
      y = event.y.round() / YFACT;
      z = event.z.round() / ZFACT;
    });
  }

  double get x => _x;
  double get y => _y;
  double get z => _z;

  set x(double val) {
    if (val != null) {
      _x = val;
      notifyListeners();
    }
  }

  set y(double val) {
    if (val != null) {
      _y = val;
      notifyListeners();
    }
  }

  set z(double val) {
    if (val != null) {
      _z = val;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _streamSubscription?.cancel();
  }
}
