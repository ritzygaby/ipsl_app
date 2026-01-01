import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../data/formation_data.dart';

class ContinuousEducationPage extends StatelessWidget {
  const ContinuousEducationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final continuousFormations = formationsData
        .where((f) => f.type == FormationType.formationContinue)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Formation Continue'),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
      ),
      body: continuousFormations.isEmpty
          ? const Center(child: Text('Aucune formation disponible.'))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: continuousFormations.length,
              itemBuilder: (context, index) {
                return _buildFormationCard(context, continuousFormations[index]);
              },
            ),
    );
  }

  Widget _buildFormationCard(BuildContext context, Formation formation) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          _showDetailsDialog(context, formation);
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: AppColors.secondary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.workspace_premium, color: AppColors.secondary, size: 30),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          formation.title,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          formation.subtitle,
                          style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                formation.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.grey.shade700),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   if (formation.practicalInfo.containsKey('Durée')) ...[
                     Row(
                       children: [
                         const Icon(Icons.timer_outlined, size: 16, color: Colors.grey),
                         const SizedBox(width: 4),
                         Text(
                           formation.practicalInfo['Durée']!,
                           style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
                         ),
                       ],
                     ),
                   ],
                  TextButton(
                    onPressed: () => _showDetailsDialog(context, formation),
                    child: const Text('En savoir plus'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDetailsDialog(BuildContext context, Formation formation) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(formation.title, style: const TextStyle(fontWeight: FontWeight.bold)),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(formation.description),
              const SizedBox(height: 16),
              const Text('Public Cible :', style: TextStyle(fontWeight: FontWeight.bold)),
              if (formation.admissionRequirements.isNotEmpty)
                ...formation.admissionRequirements.map((e) => Text('• $e')).toList()
              else
                const Text('Ouvert à tous'),
              const SizedBox(height: 16),
              if (formation.practicalInfo.isNotEmpty) ...[
                const Text('Infos Pratiques :', style: TextStyle(fontWeight: FontWeight.bold)),
                ...formation.practicalInfo.entries.map(
                  (e) => Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(e.key, style: TextStyle(color: AppColors.textSecondary)),
                        Text(e.value, style: const TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Fermer'),
          ),
          ElevatedButton(
            onPressed: () {
              // TODO: Implement registration flow
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Contactez l\'administration pour vous inscrire.')),
              );
            },
            child: const Text('S\'inscrire'),
          ),
        ],
      ),
    );
  }
}
