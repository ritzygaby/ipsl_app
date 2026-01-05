import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../data/teacher_data.dart';

class TeacherPublicProfilePage extends StatelessWidget {
  final String teacherName;

  const TeacherPublicProfilePage({super.key, required this.teacherName});

  @override
  Widget build(BuildContext context) {
    // Fetch data (mock)
    final teacher = TeacherMockData.getTeacherByName(teacherName);

    return Scaffold(
      appBar: AppBar(
        title: Text('Profil de l\'Enseignant'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(context, teacher),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  _buildInfoCard(
                    title: 'Parcours',
                    content: teacher.careerPath,
                    icon: Icons.history_edu,
                  ),
                  const SizedBox(height: 16),
                  _buildInfoCard(
                    title: 'CV - Expérience',
                    content: teacher.cvContent,
                    icon: Icons.work_outline,
                  ),
                   const SizedBox(height: 16),
                  _buildInfoCard(
                    title: 'Contact',
                    content: 'Email: ${teacher.email}\nTéléphone: ${teacher.phone}',
                    icon: Icons.contact_mail,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, TeacherProfile teacher) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 40, bottom: 40),
      decoration: BoxDecoration(
        color: AppColors.primary,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primary, AppColors.secondary],
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.white,
            child: const Icon(Icons.person, size: 60, color: Colors.grey),
          ),
          const SizedBox(height: 16),
          Text(
            teacher.name,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              'Enseignant IPSL',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard({required String title, required String content, required IconData icon}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: AppColors.primary),
              const SizedBox(width: 10),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const Divider(height: 24),
          Text(
            content.isNotEmpty ? content : 'Aucune information disponible.',
            style: const TextStyle(
              fontSize: 15,
              color: AppColors.textSecondary,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
