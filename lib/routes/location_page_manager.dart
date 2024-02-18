import 'dart:async';
import 'package:flutter/material.dart';

class LocationPageManager<LatLng> extends ChangeNotifier {
  late Completer<LatLng> _completer;

  Future<LatLng> waitForResult() async {
    _completer = Completer<LatLng>();
    return _completer.future;
  }

  void returnData(LatLng value) {
    _completer.complete(value);
  }
}
