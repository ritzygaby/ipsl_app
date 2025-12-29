import 'package:flutter/material.dart';

class Event {
  final String title;
  final DateTime date;
  final String time;
  final String speaker;
  final String speakerRole;
  final String location;
  final String type; // e.g., 'CONFÉRENCE'
  final bool isPast;

  const Event({
    required this.title,
    required this.date,
    required this.time,
    required this.speaker,
    required this.speakerRole,
    required this.location,
    required this.type,
    required this.isPast,
  });
}

final List<Event> eventsData = [
  Event(
    title: 'Inclusion scolaire au Cameroun : réalité et enjeux',
    date: DateTime(2025, 12, 23),
    time: '12h00 - 14h00',
    speaker: 'Dr. ATANGANA VIRGINIE',
    speakerRole: 'Chargé de Cours à l\'Ecole Normale Supérieure (ENS) de L\'Université de Bertoua',
    location: 'IPSL Campus Mfandena / En Ligne',
    type: 'CONFÉRENCE',
    isPast: true,
  ),
  Event(
    title: 'Comprendre le crime et la délinquance à travers la structure limite de la personnalité',
    date: DateTime(2025, 12, 18),
    time: '10h00 - 12h00',
    speaker: 'Dr. MVONDO MEKA Manuela',
    speakerRole: 'Psychologue Clinicienne / Chargée de Cours à l\'Université de Ngaoundéré',
    location: 'IPSL Campus Mfandena / En Ligne',
    type: 'CONFÉRENCE',
    isPast: true,
  ),
  // Placeholder for future event
  Event(
    title: 'Séminaire : Les enjeux de la Cybercriminalité',
    date: DateTime(2026, 01, 15),
    time: '09h00 - 16h00',
    speaker: 'Experts invités',
    speakerRole: 'Spécialistes en cybersécurité et droit numérique',
    location: 'IPSL Campus Mfandena',
    type: 'SÉMINAIRE',
    isPast: false,
  ),
];
