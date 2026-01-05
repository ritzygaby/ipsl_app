import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../data/formation_data.dart';

class FormationDetailsPage extends StatelessWidget {
  final Formation formation;

  const FormationDetailsPage({super.key, required this.formation});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            backgroundColor: AppColors.primary,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                formation.title,
                style: const TextStyle(fontSize: 14), // Smaller font for long titles
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [AppColors.primary, AppColors.secondary],
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.school_rounded,
                    size: 80,
                    color: Colors.white.withOpacity(0.2),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.orange.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      formation.subtitle,
                      style: TextStyle(
                        color: AppColors.orange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Description',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    formation.description,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColors.textSecondary,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 32),
                  
                  _buildSectionTitle(context, 'Infos Pratiques'),
                  const SizedBox(height: 16),
                  _buildPracticalInfoGrid(formation.practicalInfo),

                  const SizedBox(height: 32),
                  _buildSectionTitle(context, 'Modules Clés'),
                  const SizedBox(height: 8),
                  ...formation.modules.map((m) => _buildBulletPoint(m.title)),

                  const SizedBox(height: 32),
                  _buildSectionTitle(context, 'Débouchés'),
                  const SizedBox(height: 8),
                  ...formation.opportunities.map((o) => _buildBulletPoint(o)),
                  
                  const SizedBox(height: 32),
                  _buildSectionTitle(context, 'Conditions d\'admission'),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.primary.withOpacity(0.1)),
                    ),
                    child: Column(
                      children: formation.admissionRequirements.map((r) => _buildBulletPoint(r)).toList(),
                    ),
                  ),

                  const SizedBox(height: 32),
                  _buildSectionTitle(context, 'Dossier de Candidature'),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.secondary.withOpacity(0.2)),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.secondary.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        _buildBulletPoint('Une fiche de candidature'),
                        _buildBulletPoint('Une photocopie certifiée conforme de l\'acte de naissance'),
                        _buildBulletPoint('Copie de la pièce d\'identité'),
                        _buildBulletPoint('Les photocopies certifiées conformes des diplômes'),
                        _buildBulletPoint('Quatre photos d\'identité 4*4'),
                        _buildBulletPoint('Un certificat médical délivré par un médecin généraliste'),
                        _buildBulletPoint('Un curriculum vitae détaillé'),
                        _buildBulletPoint('Un certificat de travail (pour les travailleurs)'),
                        _buildBulletPoint('Une lettre de motivation'),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),
                  _buildSectionTitle(context, 'Procédure de candidature'),
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.primary.withOpacity(0.1)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Envoyer le dossier complet par email à :',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.email_outlined, size: 16, color: AppColors.primary),
                            const SizedBox(width: 8),
                            SelectableText(
                              'ipsl.yaounde@gmail.com',
                              style: TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Ou déposer directement à la réception de IPSL :',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.location_on_outlined, size: 16, color: AppColors.primary),
                            const SizedBox(width: 8),
                            const Expanded(
                              child: Text(
                                'Campus de Mfandena (face immeuble beau séjour)',
                                style: TextStyle(color: AppColors.textSecondary),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 40),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                         ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Veuillez suivre la procédure de candidature ci-dessus.')),
                        );
                      },
                      child: const Text('POSTULER MAINTENANT'),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 24,
          decoration: BoxDecoration(
            color: AppColors.accent,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildPracticalInfoGrid(Map<String, String> info) {
    // Separate long text items to display them full width
    final longItems = ['Rythme', 'Mode'];
    final gridItems = Map<String, String>.from(info)
      ..removeWhere((key, value) => longItems.contains(key));
    
    final fullWidthItems = Map<String, String>.from(info)
      ..removeWhere((key, value) => !longItems.contains(key));

    return Column(
      children: [
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          childAspectRatio: 2.2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          children: gridItems.entries.map((e) => _buildInfoCard(e.key, e.value)).toList(),
        ),
        if (fullWidthItems.isNotEmpty) ...[
          const SizedBox(height: 12),
          ...fullWidthItems.entries.map((e) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _buildInfoCard(e.key, e.value, isFullWidth: true),
          )),
        ],
      ],
    );
  }

  Widget _buildInfoCard(String title, String value, {bool isFullWidth = false}) {
    return Container(
      width: isFullWidth ? double.infinity : null,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Icon(Icons.circle, size: 6, color: AppColors.primary),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(text, style: const TextStyle(height: 1.4)),
          ),
        ],
      ),
    );
  }
}
