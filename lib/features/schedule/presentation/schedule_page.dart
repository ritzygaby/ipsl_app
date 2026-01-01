
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../student/data/mock_database.dart';

class SchedulePage extends StatelessWidget {
  const SchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Group schedule items by day
    final Map<String, List<ScheduleItem>> scheduleByDay = {
      'Lundi': [],
      'Mardi': [],
      'Mercredi': [],
      'Jeudi': [],
      'Vendredi': [],
      'Samedi': [],
    };

    for (var item in MockDatabase.schedule) {
      if (scheduleByDay.containsKey(item.dayOfWeek)) {
        scheduleByDay[item.dayOfWeek]!.add(item);
      }
    }

    // Sort items by start time
    scheduleByDay.forEach((key, list) {
      list.sort((a, b) {
        final aMinutes = a.startTime.hour * 60 + a.startTime.minute;
        final bMinutes = b.startTime.hour * 60 + b.startTime.minute;
        return aMinutes.compareTo(bMinutes);
      });
    });

    final today = _getFrenchDay(DateTime.now().weekday);
    final isDistance = MockDatabase.isDistanceStudent;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isDistance ? 'Emploi du temps (Distance)' : 'Emploi du temps',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        actions: [
          if (isDistance)
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Chip(
                label: const Text('En Ligne', style: TextStyle(color: Colors.white, fontSize: 12)),
                backgroundColor: Colors.purple,
                side: BorderSide.none,
                padding: const EdgeInsets.all(4),
              ),
            )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: scheduleByDay.entries.map((entry) {
          if (entry.value.isEmpty) return const SizedBox.shrink();
          final isToday = entry.key == today;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: [
                    Text(
                      entry.key,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isToday ? AppColors.primary : AppColors.textPrimary,
                      ),
                    ),
                    if (isToday)
                      Container(
                        margin: const EdgeInsets.only(left: 8),
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          "Aujourd'hui",
                          style: TextStyle(
                            fontSize: 10,
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              ...entry.value.map((item) {
                final course = MockDatabase.getCourseById(item.courseId);
                return _buildScheduleCard(item, course, isDistance);
              }).toList(),
              const SizedBox(height: 16),
            ],
          );
        }).toList(),
      ),
    );
  }

  String _getFrenchDay(int weekday) {
    const days = ['Lundi', 'Mardi', 'Mercredi', 'Jeudi', 'Vendredi', 'Samedi', 'Dimanche'];
    return days[weekday - 1];
  }

  Widget _buildScheduleCard(ScheduleItem item, Course? course, bool isDistance) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border(
          left: BorderSide(color: isDistance ? Colors.purple : AppColors.secondary, width: 4),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${item.startTime.hour.toString().padLeft(2, '0')}:${item.startTime.minute.toString().padLeft(2, '0')}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${item.endTime.hour.toString().padLeft(2, '0')}:${item.endTime.minute.toString().padLeft(2, '0')}',
                      style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
                    ),
                  ],
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        course?.name ?? 'Cours inconnu',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            isDistance ? Icons.video_camera_front_outlined : Icons.location_on_outlined, 
                            size: 14, 
                            color: isDistance ? Colors.purple : AppColors.textSecondary
                          ),
                          const SizedBox(width: 4),
                          Text(
                            isDistance ? 'Classe Virtuelle (Zoom)' : item.room,
                            style: TextStyle(
                              fontSize: 12, 
                              color: isDistance ? Colors.purple : AppColors.textSecondary,
                              fontWeight: isDistance ? FontWeight.bold : FontWeight.normal,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Icon(Icons.person_outline, size: 14, color: AppColors.textSecondary),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              course?.teacherName ?? '',
                              style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (isDistance)
               Padding(
                 padding: const EdgeInsets.only(top: 8.0),
                 child: Align(
                   alignment: Alignment.centerRight,
                   child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.videocam, size: 16),
                      label: const Text('Rejoindre'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple.withOpacity(0.1),
                        foregroundColor: Colors.purple,
                        elevation: 0,
                        minimumSize: const Size(100, 36),
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                      ),
                   ),
                 ),
               ),
          ],
        ),
      ),
    );
  }
}
