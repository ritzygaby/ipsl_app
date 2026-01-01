
import 'package:flutter/material.dart';

class Course {
  final String id;
  final String name;
  final String code;
  final int coefficient;
  final String teacherName;

  const Course({
    required this.id,
    required this.name,
    required this.code,
    required this.coefficient,
    required this.teacherName,
  });
}

class Grade {
  final String id;
  final String courseId;
  final double value;
  final double coefficient;
  final String evaluationType; // 'Devoir', 'Partiel', 'Examen'
  final DateTime date;

  const Grade({
    required this.id,
    required this.courseId,
    required this.value,
    required this.coefficient,
    required this.evaluationType,
    required this.date,
  });
}

class ScheduleItem {
  final String id;
  final String courseId;
  final String dayOfWeek; // 'Lundi', 'Mardi'...
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final String room;

  const ScheduleItem({
    required this.id,
    required this.courseId,
    required this.dayOfWeek,
    required this.startTime,
    required this.endTime,
    required this.room,
  });
}

class Payment {
  final String id;
  final String label;
  final double amount;
  final double paidAmount;
  final DateTime? date;
  final String status; // 'Payé', 'En attente', 'Partiel'

  const Payment({
    required this.id,
    required this.label,
    required this.amount,
    required this.paidAmount,
    this.date,
    required this.status,
  });
}

// Mock Data Source reflecting the SQL Dump structure
class MockDatabase {
  static const String studentName = "Gaby";
  static const String className = "Master 1 - Psychocriminologie";
  static const String academicYear = "2024/2025";
  static bool isDistanceStudent = false; // Toggle for Presential vs Distance interface differentiation

  static const List<Course> courses = [
    Course(id: '1', name: 'Psychopathologie Clinique', code: 'PSY101', coefficient: 4, teacherName: 'Dr. Karem'),
    Course(id: '2', name: 'Droit Pénal Général', code: 'DRO201', coefficient: 3, teacherName: 'Prof. Gay Woods'),
    Course(id: '3', name: 'Méthodologie de Recherche', code: 'MET301', coefficient: 2, teacherName: 'Dr. Whitley'),
    Course(id: '4', name: 'Anglais Technique', code: 'ANG401', coefficient: 2, teacherName: 'Mme. Lott'),
    Course(id: '5', name: 'Criminologie Appliquée', code: 'CRI501', coefficient: 5, teacherName: 'Prof. Reyes'),
  ];

  static final List<Grade> grades = [
    Grade(id: '1', courseId: '1', value: 15.0, coefficient: 4, evaluationType: 'Partiel', date: DateTime(2024, 11, 15)),
    Grade(id: '2', courseId: '1', value: 14.5, coefficient: 4, evaluationType: 'TP', date: DateTime(2024, 12, 01)),
    Grade(id: '3', courseId: '2', value: 12.0, coefficient: 3, evaluationType: 'Partiel', date: DateTime(2024, 11, 20)),
    Grade(id: '4', courseId: '3', value: 16.0, coefficient: 2, evaluationType: 'Devoir', date: DateTime(2024, 10, 30)),
    Grade(id: '5', courseId: '4', value: 18.0, coefficient: 2, evaluationType: 'Oral', date: DateTime(2024, 12, 05)),
    Grade(id: '6', courseId: '5', value: 13.5, coefficient: 5, evaluationType: 'Partiel', date: DateTime(2024, 11, 25)),
  ];

  static const List<ScheduleItem> schedule = [
    ScheduleItem(id: '1', courseId: '1', dayOfWeek: 'Lundi', startTime: TimeOfDay(hour: 8, minute: 0), endTime: TimeOfDay(hour: 11, minute: 0), room: 'Amphi A'),
    ScheduleItem(id: '2', courseId: '3', dayOfWeek: 'Lundi', startTime: TimeOfDay(hour: 14, minute: 0), endTime: TimeOfDay(hour: 17, minute: 0), room: 'Salle 102'),
    ScheduleItem(id: '3', courseId: '2', dayOfWeek: 'Mardi', startTime: TimeOfDay(hour: 9, minute: 0), endTime: TimeOfDay(hour: 12, minute: 0), room: 'Salle 204'),
    ScheduleItem(id: '4', courseId: '5', dayOfWeek: 'Mercredi', startTime: TimeOfDay(hour: 8, minute: 0), endTime: TimeOfDay(hour: 12, minute: 0), room: 'Labo C'),
    ScheduleItem(id: '5', courseId: '4', dayOfWeek: 'Jeudi', startTime: TimeOfDay(hour: 10, minute: 0), endTime: TimeOfDay(hour: 12, minute: 0), room: 'Salle Langues'),
    ScheduleItem(id: '6', courseId: '1', dayOfWeek: 'Vendredi', startTime: TimeOfDay(hour: 15, minute: 0), endTime: TimeOfDay(hour: 18, minute: 0), room: 'Amphi B'),
  ];

  static final List<Payment> payments = [
    Payment(id: '1', label: 'Inscription', amount: 150000, paidAmount: 150000, date: DateTime(2024, 9, 15), status: 'Payé'),
    Payment(id: '2', label: 'Tranche 1', amount: 200000, paidAmount: 200000, date: DateTime(2024, 10, 15), status: 'Payé'),
    Payment(id: '3', label: 'Tranche 2', amount: 200000, paidAmount: 50000, date: DateTime(2024, 11, 15), status: 'Partiel'),
    Payment(id: '4', label: 'Tranche 3', amount: 200000, paidAmount: 0, status: 'En attente'),
  ];

  static Course? getCourseById(String id) {
    try {
      return courses.firstWhere((c) => c.id == id);
    } catch (e) {
      return null;
    }
  }

  static double calculateAverage() {
    double totalPoints = 0;
    double totalCoef = 0;

    for (var grade in grades) {
      totalPoints += grade.value * grade.coefficient;
      totalCoef += grade.coefficient;
    }

    if (totalCoef == 0) return 0.0;
    return double.parse((totalPoints / totalCoef).toStringAsFixed(2));
  }

  static int calculateCredits() {
    // Mock logic: sum of coefficients of courses with grades > 10
    // Simplified: just sum of all course coefficients for now as "potential credits"
    return courses.fold(0, (sum, course) => sum + course.coefficient); 
  }
}
