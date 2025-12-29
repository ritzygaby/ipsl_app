import 'package:flutter/material.dart';

class Formation {
  final String title;
  final String subtitle;
  final String description;
  final List<String> objectives;
  final List<String> opportunities;
  final List<String> modules;
  final Map<String, String> practicalInfo; // e.g., 'Frais': '600.000 FCFA'
  final List<String> admissionRequirements;

  const Formation({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.objectives,
    required this.opportunities,
    required this.modules,
    required this.practicalInfo,
    required this.admissionRequirements,
  });
}

final List<Formation> formationsData = [
  Formation(
    title: 'Psychocriminologie et Psychotraumatologie',
    subtitle: 'Master Professionnel - Option A',
    description: 'Cette option permet de développer des compétences dans les pratiques expertales et thérapeutiques réalisées à l\'interface santé-justice. Elle s\'adresse aux psychologues et professionnels de santé souhaitant se spécialiser dans l\'expertise médico-psychologique et l\'accompagnement des victimes et auteurs.',
    objectives: [
      'Développer une compréhension théorique et appliquée des comportements criminels.',
      'Former des analystes et experts capables de réaliser des expertises médico-psychologiques.',
      'Sensibiliser aux enjeux éthiques et déontologiques.',
      'Encourager la recherche scientifique en psychopathologie criminelle.'
    ],
    opportunities: [
      'Milieux institutionnels : établissements pénitentiaires, services socio-judiciaires.',
      'Centres d\'expertise et d\'investigation judiciaires.',
      'Associations et ONG : accompagnement des victimes.',
      'Secteur académique et recherche.'
    ],
    modules: [
      'Psychopathologie de la violence',
      'Introduction à la psychotraumatologie',
      'Pratiques expertales en matière pénale et civile',
      'Diagnostic en psychopathologie et en psychiatrie',
      'Pratique des thérapies forensiques',
      'Groupes et institutions',
      'Méthodologie de la recherche'
    ],
    practicalInfo: {
      'Niveau': 'Bac + 5',
      'Durée': '2 ans (4 semestres)',
      'Crédits': '120 ECTS',
      'Coût': '600.000 FCFA/an',
      'Frais de dossier': '30.000 FCFA',
      'Rythme': 'Mar, Mer, Ven (17h30-21h30) & Week-ends',
      'Mode': 'Hybride (Visioconférence et Présentiel)',
    },
    admissionRequirements: [
      'Licence en Psychologie requise pour l\'obtention du Master.',
      'Étudiants en sciences de la santé et sciences humaines (médecine, infirmières, socio, philo...).',
      'Professionnels de la santé, justice, social, éducation.'
    ],
  ),
  Formation(
    title: 'Droit et Sciences Criminelles',
    subtitle: 'Master Professionnel - Option B',
    description: 'Cette option permet de consolider les compétences sur l\'étude et l\'analyse de phénomènes criminels, y compris la cybercriminalité, et sur les investigations judiciaires (scènes de crime, analyses des traces, analyses chimiques, etc.).',
    objectives: [
      'Acquérir des compétences pointues en procédure pénale et criminalistique.',
      'Maîtriser les techniques d\'investigation modernes (cybercriminalité, scène de crime).',
      'Analyser les phénomènes criminels contemporains.',
      'Comprendre les politiques judiciaires internationales.'
    ],
    opportunities: [
      'Forces de police et gendarmerie (analystes, enquêteurs spécialisés).',
      'Tribunaux et services judiciaires.',
      'Structures de prévention de la délinquance.',
      'Experts assistants et consultants en sécurité.'
    ],
    modules: [
      'Droit et politiques judiciaires',
      'Cybercriminalité et sécurité numérique',
      'Scènes de crime et recherche des preuves',
      'Investigations judiciaires',
      'Sciences légales et justice',
      'Introduction à la criminologie et victimologie',
      'Analyse de la criminalité'
    ],
    practicalInfo: {
      'Niveau': 'Bac + 5',
      'Durée': '2 ans (4 semestres)',
      'Crédits': '120 ECTS',
      'Coût': '600.000 FCFA/an',
      'Frais de dossier': '30.000 FCFA',
      'Rythme': 'Mar, Mer, Ven (17h30-21h30) & Week-ends',
      'Mode': 'Hybride (Visioconférence et Présentiel)',
    },
    admissionRequirements: [
      'Licence en Droit requise pour l\'obtention du Master.',
      'Étudiants en sciences juridiques et politiques.',
      'Professionnels de la justice et de la sécurité.'
    ],
  ),
];
