import 'package:flutter/material.dart';

enum FormationType {
  bts,
  licence,
  master,
  formationContinue,
}

extension FormationTypeExtension on FormationType {
  String get label {
    switch (this) {
      case FormationType.bts:
        return 'BTS';
      case FormationType.licence:
        return 'LICENCE';
      case FormationType.master:
        return 'MASTER';
      case FormationType.formationContinue:
        return 'FORMATION CONTINUE';
    }
  }
}

enum ResourceType {
  pdf,
  video,
}

class CourseResource {
  final String title;
  final ResourceType type;
  final String url;

  const CourseResource({
    required this.title,
    required this.type,
    required this.url,
  });
}

class Module {
  final String title;
  final List<CourseResource> resources;

  const Module({
    required this.title,
    this.resources = const [],
  });
}

class Formation {
  final String title;
  final String subtitle;
  final String description;
  final List<String> objectives;
  final List<String> opportunities;
  final List<Module> modules;
  final Map<String, String> practicalInfo; // e.g., 'Frais': '600.000 FCFA'
  final List<String> admissionRequirements;
  final FormationType type;
  // Legacy global resources, kept for backwards compatibility or global docs
  final List<CourseResource> resources;
  final List<String> classrooms;

  const Formation({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.objectives,
    required this.opportunities,
    required this.modules,
    required this.practicalInfo,
    required this.admissionRequirements,
    required this.type,
    this.resources = const [],
    this.classrooms = const [],
  });
}

final List<Formation> formationsData = [
  // --- MASTER ---
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
      Module(
        title: 'Psychopathologie de la violence',
        resources: [
             CourseResource(
              title: 'Introduction à la Criminologie',
              type: ResourceType.video,
              url: 'https://www.youtube.com/watch?v=PrJqWDTbTTA',
            ),
        ],
      ),
      Module(title: 'Introduction à la psychotraumatologie'),
      Module(title: 'Pratiques expertales en matière pénale et civile'),
      Module(title: 'Diagnostic en psychopathologie et en psychiatrie'),
      Module(title: 'Pratique des thérapies forensiques'),
      Module(title: 'Groupes et institutions'),
      Module(title: 'Méthodologie de la recherche'),
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
    type: FormationType.master,
    resources: const [
      CourseResource(
        title: 'Syllabus du Master',
        type: ResourceType.pdf,
        url: 'https://ipsl.edu.sn/documents/syllabus_master_psycho.pdf',
      ),
    ],
    classrooms: ['Salle A', 'Salle Conférence', 'Amphi 2'],
  ),
  Formation(
    title: 'Sciences Criminelles',
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
      Module(title: 'Droit et politiques judiciaires'),
      Module(title: 'Cybercriminalité et sécurité numérique'),
      Module(title: 'Scènes de crime et recherche des preuves'),
      Module(title: 'Investigations judiciaires'),
      Module(title: 'Sciences légales et justice'),
      Module(title: 'Introduction à la criminologie et victimologie'),
      Module(title: 'Analyse de la criminalité'),
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
    type: FormationType.master,
    classrooms: ['Salle B', 'Labo Criminalistique'],
  ),

  // --- BTS ---
  Formation(
    title: 'Sciences de l\'Education',
    subtitle: 'Brevet de Technicien Supérieur (BTS)',
    description: 'Formation professionnalisante dans les métiers de l\'éducation et de l\'encadrement scolaire.',
    objectives: [
      'Maîtriser les techniques d\'éducation spécialisée.',
      'Accompagner l\'orientation scolaire et professionnelle.',
      'Gérer l\'administration scolaire.'
    ],
    opportunities: [
      'Établissements scolaires.',
      'Centres d\'orientation.',
      'Structures d\'éducation spécialisée.'
    ],
    modules: [
      Module(title: 'Education spécialisée'),
      Module(title: 'Orientation scolaire et professionnelle'),
      Module(title: 'Administration scolaire'),
    ],
    practicalInfo: {
      'Niveau': 'Bac + 2',
      'Durée': '2 ans (4 semestres)',
      'Coût': '300.000 CFA/an',
      'Frais de dossier': '30.000 CFA',
    },
    admissionRequirements: [
      'Baccalauréat toutes séries.'
    ],
    type: FormationType.bts,
  ),
  Formation(
    title: 'Carrières Juridiques',
    subtitle: 'Brevet de Technicien Supérieur (BTS)',
    description: 'Formation aux métiers du droit en entreprise et administration.',
    objectives: [
      'Assister les professionnels du droit.',
      'Gérer les aspects juridiques de l\'entreprise.',
      'Maîtriser le droit foncier et domanial.'
    ],
    opportunities: [
      'Cabinets d\'avocats et notaires.',
      'Services juridiques d\'entreprises.',
      'Administration foncière.'
    ],
    modules: [
      Module(title: 'Assistant juridique'),
      Module(title: 'Droit des affaires et de l\'entreprise'),
      Module(title: 'Droit foncier et domanial'),
    ],
    practicalInfo: {
      'Niveau': 'Bac + 2',
      'Durée': '2 ans (4 semestres)',
      'Coût': '300.000 CFA/an',
      'Frais de dossier': '30.000 CFA',
    },
    admissionRequirements: [
      'Baccalauréat toutes séries.'
    ],
    type: FormationType.bts,
  ),

  // --- LICENCE ---
  Formation(
    title: 'Sciences de l\'éducation',
    subtitle: 'Licence : Education spécialisée',
    description: 'Formation universitaire de premier cycle axée sur l\'éducation spécialisée.',
    objectives: [
      'Approfondir les connaissances en sciences de l\'éducation.',
      'Se spécialiser dans l\'accompagnement des publics à besoins spécifiques.'
    ],
    opportunities: [
      'Enseignement spécialisé.',
      'Coordination de projets éducatifs.',
      'Poursuite en Master.'
    ],
    modules: [
      Module(title: 'Pédagogie spécialisée'),
      Module(title: 'Psychologie de l\'enfant'),
      Module(title: 'Sociologie de l\'éducation'),
    ],
    practicalInfo: {
      'Niveau': 'Bac + 3',
      'Durée': '3 ans (6 semestres)',
      'Coût': '450.000 FCFA/an',
      'Frais de dossier': '30.000 CFA',
    },
    admissionRequirements: [
      'Baccalauréat A, D, C, F8.'
    ],
    type: FormationType.licence,
  ),
  Formation(
    title: 'Orthophonie',
    subtitle: 'Licence Professionnelle',
    description: 'Traitement des troubles du langage (troubles et handicaps au niveau du langage, de la parole, de la phonation, de la déglutition, de la lecture et de l\'écriture).',
    objectives: [
      'Diagnostiquer les troubles de la communication.',
      'Concevoir et mettre en œuvre des plans de rééducation.',
      'Travailler en équipe pluridisciplinaire.'
    ],
    opportunities: [
      'Cabinets d\'orthophonie.',
      'Hôpitaux et cliniques.',
      'Centres médico-psychologiques.'
    ],
    modules: [
      Module(title: 'Anatomie et physiologie de la phonation'),
      Module(title: 'Linguistique clinique'),
      Module(title: 'Psychologie du développement'),
      Module(title: 'Techniques de rééducation'),
    ],
    practicalInfo: {
      'Niveau': 'Bac + 3',
      'Durée': '3 ans (6 semestres)',
      'Coût': '450.000 FCFA/an',
      'Frais de dossier': '30.000 CFA',
    },
    admissionRequirements: [
      'Baccalauréat A, D, C, F8.'
    ],
    type: FormationType.licence,
  ),

  // --- FORMATIONS CONTINUES ---
  Formation(
    title: 'Audition des mineurs',
    subtitle: 'Formation Continue',
    description: 'Formation spécialisée pour l\'audition des mineurs en contexte judiciaire ou social.',
    objectives: ['Maîtriser les protocoles d\'audition de mineurs.'],
    opportunities: [],
    modules: [],
    practicalInfo: {
      'Durée': '1 an',
      'Coût': '300.000 FCFA',
    },
    admissionRequirements: [
      'BAC + 3 / Diplôme équivalent.',
      'Public : Psychologues, juges pour enfants, avocats, travailleurs sociaux, magistrats, juristes, policiers, éducateurs spécialisés, infirmiers.'
    ],
    type: FormationType.formationContinue,
  ),
  Formation(
    title: 'Audition des adultes',
    subtitle: 'Formation Continue',
    description: 'Techniques d\'audition adaptées aux adultes.',
    objectives: [],
    opportunities: [],
    modules: [],
    practicalInfo: {
      'Durée': '1 an',
      'Coût': '300.000 FCFA',
    },
    admissionRequirements: [
      'BAC + 3 / Diplôme équivalent.',
      'Public : Psychologues, magistrats, avocats, policiers, travailleurs sociaux, infirmiers.'
    ],
    type: FormationType.formationContinue,
  ),
  Formation(
    title: 'Exécution des peines',
    subtitle: 'Formation Continue',
    description: 'Suivi et application des peines judiciaires.',
    objectives: [],
    opportunities: [],
    modules: [],
    practicalInfo: {
      'Durée': '1 an',
      'Coût': '300.000 FCFA',
    },
    admissionRequirements: [
      'BAC + 3 / Diplôme équivalent.',
      'Public : Magistrats, greffiers, avocats pénalistes, agents pénitentiaires, psychologues, infirmiers.'
    ],
    type: FormationType.formationContinue,
  ),
  Formation(
    title: 'Maltraitances infantiles',
    subtitle: 'Formation Continue',
    description: 'Détection et prise en charge des maltraitances infantiles.',
    objectives: [],
    opportunities: [],
    modules: [],
    practicalInfo: {
      'Durée': '1 an',
      'Coût': '300.000 FCFA',
    },
    admissionRequirements: [
      'BAC + 3 / Diplôme équivalent.',
      'Public : Psychologues, travailleurs sociaux, enseignants, magistrats, médecins, infirmiers.'
    ],
    type: FormationType.formationContinue,
  ),
  Formation(
    title: 'Violences conjugales',
    subtitle: 'Formation Continue',
    description: 'Comprendre et intervenir dans les situations de violences conjugales.',
    objectives: [],
    opportunities: [],
    modules: [],
    practicalInfo: {
      'Durée': '1 an',
      'Coût': '300.000 FCFA',
    },
    admissionRequirements: [
      'BAC + 3 / Diplôme équivalent.',
      'Public : Psychologues, juristes, travailleurs sociaux, soignants, policiers, infirmiers.'
    ],
    type: FormationType.formationContinue,
  ),
  Formation(
    title: 'Clinique des violences sexuelles',
    subtitle: 'Formation Continue',
    description: 'Approche clinique des auteurs et victimes de violences sexuelles.',
    objectives: [],
    opportunities: [],
    modules: [],
    practicalInfo: {
      'Durée': '1 an',
      'Coût': '300.000 FCFA',
    },
    admissionRequirements: [
      'BAC + 3 / Diplôme équivalent.',
      'Public : Psychologues, psychiatres, médecins, magistrats, travailleurs sociaux, infirmiers.'
    ],
    type: FormationType.formationContinue,
  ),
  Formation(
    title: 'Troubles du neurodéveloppement (TSA-TDAH-Dys)',
    subtitle: 'Formation Continue',
    description: 'Prise en charge des troubles du neurodéveloppement.',
    objectives: [],
    opportunities: [],
    modules: [],
    practicalInfo: {
      'Durée': '1 an',
      'Coût': '300.000 FCFA',
    },
    admissionRequirements: [
      'BAC + 3 / Diplôme équivalent.',
      'Public : Psychologues, neuropsychologues, orthophonistes, enseignants spécialisés, médecins, infirmiers.'
    ],
    type: FormationType.formationContinue,
  ),
  Formation(
    title: 'Psychothérapie d\'orientation psychanalytique',
    subtitle: 'Formation Continue',
    description: 'Formation approfondie en thérapie psychanalytique.',
    objectives: [],
    opportunities: [],
    modules: [],
    practicalInfo: {
      'Durée': '2 ans',
      'Coût': '500.000 CFA/an',
    },
    admissionRequirements: [
      'Master en psychologie.',
      'Public : Psychologues, Médecins.'
    ],
    type: FormationType.formationContinue,
  ),
  Formation(
    title: 'Psychothérapie d\'orientation systémique',
    subtitle: 'Formation Continue',
    description: 'Formation approfondie en thérapie systémique.',
    objectives: [],
    opportunities: [],
    modules: [],
    practicalInfo: {
      'Durée': '2 ans',
      'Coût': '500.000 CFA/an',
    },
    admissionRequirements: [
      'Master en psychologie.',
      'Public : Psychologues, Médecins.'
    ],
    type: FormationType.formationContinue,
  ),
  Formation(
    title: 'Psychothérapie d\'orientation cognitivo-comportementale',
    subtitle: 'Formation Continue',
    description: 'Formation approfondie en TCC.',
    objectives: [],
    opportunities: [],
    modules: [],
    practicalInfo: {
      'Durée': '2 ans',
      'Coût': '500.000 CFA/an',
    },
    admissionRequirements: [
      'Master en psychologie.',
      'Public : Psychologues, Médecins.'
    ],
    type: FormationType.formationContinue,
  ),
];
