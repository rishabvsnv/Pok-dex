import 'package:flutter/material.dart';

abstract final class AppRadius {
  AppRadius._();

  static const Radius small = Radius.circular(10);

  static const Radius medium = Radius.circular(18);

  static const Radius large = Radius.circular(24);

  static const Radius extraLarge = Radius.circular(32);

  static const BorderRadius card = BorderRadius.all(Radius.circular(24));

  static const BorderRadius button = BorderRadius.all(Radius.circular(20));

  static const BorderRadius input = BorderRadius.all(Radius.circular(22));

  static const BorderRadius chip = BorderRadius.all(Radius.circular(100));
}
