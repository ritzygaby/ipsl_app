import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/theme/app_colors.dart';
import '../../student/data/mock_database.dart';
import '../../auth/presentation/login_page.dart';
import '../../payments/presentation/payment_history_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _profileImage;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(context),
            const SizedBox(height: 20),
            _buildSectionTitle('Informations Personnelles'),
            _buildInfoCard([
              _buildInfoRow(Icons.badge_outlined, 'Matricule', '2024-GABY-001'),
              _buildInfoRow(Icons.email_outlined, 'Email', 'gaby@ipsl.edu.sn'),
              _buildInfoRow(Icons.phone_outlined, 'Téléphone', '+221 77 000 00 00'),
              _buildInfoRow(Icons.cake_outlined, 'Date de naissance', '12 Mai 1998'),
              _buildInfoRow(Icons.location_on_outlined, 'Adresse', 'Dakar, Sénégal'),
            ]),
            const SizedBox(height: 20),
            _buildSectionTitle('Informations Académiques'),
            _buildInfoCard([
              _buildInfoRow(Icons.school_outlined, 'Établissement', 'IPSL'),
              _buildInfoRow(Icons.category_outlined, 'Filière', 'Psychocriminologie'),
              _buildInfoRow(Icons.stairs_outlined, 'Niveau', 'Master 1'),
              _buildInfoRow(Icons.calendar_month_outlined, 'Année Académique', MockDatabase.academicYear),
              _buildInfoRow(
                Icons.verified_user_outlined, 
                'Mode', 
                MockDatabase.isDistanceStudent ? 'En Ligne (Distance)' : 'Présentiel',
                valueColor: MockDatabase.isDistanceStudent ? Colors.purple : Colors.green,
                isBold: true,
              ),
            ]),
            const SizedBox(height: 20),
            _buildSectionTitle('Paramètres et Mode'),
            _buildActionCard(context),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                    (route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade50,
                  foregroundColor: Colors.red,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 0,
                  side: BorderSide(color: Colors.red.withOpacity(0.2)),
                ),
                icon: const Icon(Icons.logout_rounded),
                label: const Text('Se déconnecter', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
             const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              height: 200,
              width: double.infinity,
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
              child: SafeArea(
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      'Mon Profil',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: -50,
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 4),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      radius: 55,
                      backgroundColor: Colors.white,
                      backgroundImage: _profileImage != null 
                        ? FileImage(_profileImage!) as ImageProvider
                        : const AssetImage('assets/images/logo_ipsl.jpg'),
                      child: _profileImage == null 
                        ? const Icon(Icons.person, size: 70, color: Color(0xFFE0E0E0))
                        : null,
                    ),
                  ),
                  InkWell(
                    onTap: _pickImage,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: AppColors.secondary,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.camera_alt, color: Colors.white, size: 20),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 60), // Space for the protruding avatar
        Text(
          MockDatabase.studentName,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Text(
                MockDatabase.className,
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: MockDatabase.isDistanceStudent ? Colors.purple.withOpacity(0.1) : Colors.green.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: MockDatabase.isDistanceStudent ? Colors.purple : Colors.green),
              ),
              child: Text(
                MockDatabase.isDistanceStudent ? 'DISTANCE' : 'PRÉSENTIEL',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: MockDatabase.isDistanceStudent ? Colors.purple : Colors.green,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(List<Widget> children) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: children,
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value, {Color? valueColor, bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.05),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: AppColors.primary, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
                    color: valueColor ?? AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionCard(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          SwitchListTile(
            title: const Text('Mode Étudiant à Distance', style: TextStyle(fontWeight: FontWeight.w500)),
            subtitle: const Text('Simuler l\'interface e-learning', style: TextStyle(fontSize: 12, color: Colors.grey)),
            value: MockDatabase.isDistanceStudent,
            activeColor: Colors.purple,
            onChanged: (bool value) {
              setState(() {
                MockDatabase.isDistanceStudent = value;
              });
              // Force rebuild of app generally or show snackbar
               ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Mode changé en : ${value ? "Distance" : "Présentiel"}')),
              );
            },
            secondary: Icon(
              Icons.laptop_chromebook, 
              color: MockDatabase.isDistanceStudent ? Colors.purple : Colors.grey
            ),
          ),
          const Divider(height: 1, indent: 56),
          _buildActionTile(Icons.lock_outline, 'Changer de mot de passe', () {}),
          const Divider(height: 1, indent: 56),
          _buildActionTile(Icons.payment_outlined, 'Historique des paiements', () {
             Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PaymentHistoryPage()),
            );
          }),
          const Divider(height: 1, indent: 56),
          _buildActionTile(Icons.notifications_outlined, 'Notifications', () {}),
          const Divider(height: 1, indent: 56),
          _buildActionTile(Icons.language, 'Langue', () {}),
          const Divider(height: 1, indent: 56),
          _buildActionTile(Icons.privacy_tip_outlined, 'Politique de confidentialité', () {}),
          const Divider(height: 1, indent: 56),
          _buildActionTile(Icons.help_outline, 'Aide & FAQ', () {}),
        ],
      ),
    );
  }

  Widget _buildActionTile(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey.shade700, size: 22),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: AppColors.textPrimary,
        ),
      ),
      trailing: const Icon(Icons.chevron_right, size: 20, color: Colors.grey),
      onTap: onTap,
    );
  }
}
