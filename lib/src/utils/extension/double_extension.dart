import 'dart:math';

import 'package:flutter/material.dart';

// Double Extensions
extension DoubleExtensions on double? {
  /// Validate given double is not null and returns given value if null.
  double validate({double value = 0.0}) => this ?? value;

  bool isBetween(num first, num second) {
    final lower = min(first, second);
    final upper = max(first, second);
    return validate() >= lower && validate() <= upper;
  }

  /// Returns Size
  Size get size => Size(this!, this!);
}
