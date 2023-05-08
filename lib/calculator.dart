import 'dart:math' as math;

import 'package:flutter/material.dart';

class Calculator {
  double raio;
  late double angularVelocity;
  double time;

  Calculator(this.time, this.raio, this.angularVelocity);

  Offset positionCircumferential() {
    var x = raio * math.sin(angularVelocity * time);
    var y = raio * math.cos(angularVelocity * time);

    return Offset(x, y);
  }
}
