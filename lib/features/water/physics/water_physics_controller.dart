import 'dart:math';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class WaterPhysicsController extends ChangeNotifier {
  double tiltX = 0;
  double tiltY = 0;

  double velocityX = 0;
  double velocityY = 0;

  double _lastUpdate = 0;

  WaterPhysicsController() {
    accelerometerEventStream().listen(_onSensor);
  }

  void _onSensor(AccelerometerEvent event) {
    final now = DateTime.now().millisecondsSinceEpoch.toDouble();
    final dt = (_lastUpdate == 0) ? 0 : (now - _lastUpdate) / 1000;
    _lastUpdate = now;

    // Smooth physics
    final targetX = event.x / 10;
    final targetY = event.y / 10;

    velocityX += (targetX - tiltX) * 0.08;
    velocityY += (targetY - tiltY) * 0.08;

    velocityX *= 0.92;
    velocityY *= 0.92;

    tiltX += velocityX * dt;
    tiltY += velocityY * dt;

    notifyListeners();
  }
}