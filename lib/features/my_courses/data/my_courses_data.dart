
import 'package:flutter/material.dart';

import 'package:ipsl_app/features/formations/data/formation_data.dart';

// Simulating that the student is enrolled in Master Psychocriminologie
final List<Formation> myCoursesData = formationsData
    .where((f) => f.title.contains('Psychocriminologie'))
    .toList();
