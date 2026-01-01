
import 'package:flutter/material.dart';

import 'package:ipsl_app/features/formations/data/formation_data.dart';

final List<Formation> elearningFormations = formationsData
    .where((f) => f.type == FormationType.formationContinue)
    .toList();
