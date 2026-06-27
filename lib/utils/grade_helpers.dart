import 'package:flutter/material.dart';

/// Returns a themed color for the given letter grade.
Color gradeColor(String grade, ColorScheme cs) {
  switch (grade) {
    case 'A':
      return cs.primary;
    case 'B':
      return cs.secondary;
    case 'C':
      return cs.tertiary;
    default:
      return cs.error;
  }
}
