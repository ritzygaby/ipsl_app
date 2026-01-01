import 'package:flutter/material.dart';
import '../../features/formations/data/formation_data.dart';

class CourseService extends ChangeNotifier {
  static final CourseService _instance = CourseService._internal();
  factory CourseService() => _instance;

  CourseService._internal() {
    _courses.addAll(formationsData);
  }

  final List<Formation> _courses = [];

  List<Formation> get courses => List.unmodifiable(_courses);

  void addCourse(Formation formation) {
    _courses.add(formation);
    notifyListeners();
  }

  void updateCourse(Formation oldFormation, Formation newFormation) {
    final index = _courses.indexOf(oldFormation);
    if (index != -1) {
      _courses[index] = newFormation;
      notifyListeners();
    }
  }

  void deleteCourse(Formation formation) {
    _courses.remove(formation);
    notifyListeners();
  }
}
