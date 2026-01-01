
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class CourseContentPage extends StatelessWidget {
  final String courseTitle;

  const CourseContentPage({super.key, required this.courseTitle});

  @override
  Widget build(BuildContext context) {
    // Mock Lessons Data
    final List<Map<String, dynamic>> lessons = [
      {'title': 'Introduction au cours', 'duration': '15 min', 'type': 'video', 'isCompleted': true},
      {'title': 'Chapitre 1 : Les fondamentaux', 'duration': '45 min', 'type': 'video', 'isCompleted': true},
      {'title': 'Support de cours - Chapitre 1', 'duration': 'PDF', 'type': 'pdf', 'isCompleted': true},
      {'title': 'Quiz : Évaluation Chapitre 1', 'duration': '10 min', 'type': 'quiz', 'isCompleted': false},
      {'title': 'Chapitre 2 : Approfondissement', 'duration': '50 min', 'type': 'video', 'isCompleted': false},
      {'title': 'Support de cours - Chapitre 2', 'duration': 'PDF', 'type': 'pdf', 'isCompleted': false},
      {'title': 'Travaux Dirigés', 'duration': '1h 30', 'type': 'assignment', 'isCompleted': false},
      {'title': 'Examen Blanc', 'duration': '2h', 'type': 'exam', 'isCompleted': false},
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 150,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                courseTitle,
                style: const TextStyle(fontSize: 14),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.primary, AppColors.secondary],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Center(
                  child: Opacity(
                    opacity: 0.1,
                    child: Icon(Icons.class_, size: 80, color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final lesson = lessons[index];
                  return _buildLessonItem(context, lesson, index, lessons);
                },
                childCount: lessons.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLessonItem(BuildContext context, Map<String, dynamic> lesson, int index, List<Map<String, dynamic>> lessons) {
    IconData icon;
    Color iconColor;
    switch (lesson['type']) {
      case 'video':
        icon = Icons.play_circle_fill_rounded;
        iconColor = AppColors.primary;
        break;
      case 'pdf':
        icon = Icons.picture_as_pdf_rounded;
        iconColor = Colors.redAccent;
        break;
      case 'quiz':
        icon = Icons.quiz_rounded;
        iconColor = AppColors.orange;
        break;
      case 'assignment':
        icon = Icons.assignment_rounded;
        iconColor = Colors.blueAccent;
        break;
      case 'exam':
        icon = Icons.timer_rounded;
        iconColor = Colors.purpleAccent;
        break;
      default:
        icon = Icons.article_rounded;
        iconColor = Colors.grey;
    }

    final bool isLocked = !lesson['isCompleted'] && index > 0 && !(lessons[index - 1]['isCompleted'] as bool);
    
    // For demo purposes, let's unlock everything so user can click around
    const bool showLocked = false; 

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Container(
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
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: showLocked ? null : () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Ouverture de : ${lesson['title']}')),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: iconColor.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      icon,
                      color: showLocked ? Colors.grey : iconColor,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          lesson['title'],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: showLocked ? Colors.grey : AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          lesson['duration'],
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (lesson['isCompleted'] == true)
                    Icon(Icons.check_circle_rounded, color: AppColors.secondary, size: 24)
                  else if (showLocked)
                    Icon(Icons.lock_rounded, color: Colors.grey.shade300, size: 24)
                  else
                    Icon(Icons.play_arrow_rounded, color: Colors.grey.shade400, size: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
