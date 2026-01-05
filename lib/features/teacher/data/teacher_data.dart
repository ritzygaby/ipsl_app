class TeacherProfile {
  String name;
  String email;
  String phone;
  String careerPath; // Parcours
  String cvContent; // CV details
  String photoUrl;

  TeacherProfile({
    required this.name,
    this.email = '',
    this.phone = '',
    this.careerPath = '',
    this.cvContent = '',
    this.photoUrl = '',
  });
}

class TeacherMockData {
  static TeacherProfile currentTeacher = TeacherProfile(
    name: "Dr. Karem",
    email: "karem@ipsl.edu.sn",
    phone: "+221 77 123 45 67",
    careerPath: "Doctorat en Psychologie Clinique (2015)\nMaster en Criminologie (2012)",
    cvContent: "Spécialiste en psychopathologie clinique avec 10 ans d'expérience...",
  );
  
  // Method to get teacher by name (mock)
  static TeacherProfile getTeacherByName(String name) {
    if (name == currentTeacher.name) return currentTeacher;
    // Return a default profile for others
    return TeacherProfile(name: name, careerPath: "Information non disponible", cvContent: "Information non disponible");
  }
}
