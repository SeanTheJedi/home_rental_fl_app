import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:home_rental_application/controllers/auth_controller.dart';
import 'package:home_rental_application/views/profile/widgets/profile_app_bar.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Provider.of<AuthController>(context);
    final user = authController.currentUser;

    if (user == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: CustomScrollView(
        slivers: [
          // Dynamic Profile Header from Firebase
          ProfileAppBar(
            name: user.fullname,
            email: user.email,
            expandedHeight: 280.0,
          ),

          // Profile Menu Options
          SliverList(
            delegate: SliverChildListDelegate(
              [
                const SizedBox(height: 20),
                _buildProfileOption(
                  icon: Icons.person_outline,
                  title: "Edit Profile",
                  onTap: () {
                    // Navigate to Edit Profile
                  },
                ),
                _buildProfileOption(
                  icon: Icons.favorite_border,
                  title: "Favorites",
                  onTap: () {
                    context.push('/favourites');
                  },
                ),
                _buildProfileOption(
                  icon: Icons.settings_outlined,
                  title: "Settings",
                  onTap: () {
                    // Navigate to Settings
                  },
                ),
                _buildProfileOption(
                  icon: Icons.help_outline,
                  title: "Help & Support",
                  onTap: () {
                    // Navigate to Help
                  },
                ),
                const SizedBox(height: 20),
                _buildProfileOption(
                  icon: Icons.logout,
                  title: "Logout",
                  textColor: Colors.red,
                  iconColor: Colors.red,
                  onTap: () async {
                    // Logout Confirmation Dialog
                    final confirm = await showDialog<bool>(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Logout'),
                        content: const Text('Are you sure you want to log out?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context, false),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context, true),
                            child: const Text('Logout', style: TextStyle(color: Colors.red)),
                          ),
                        ],
                      ),
                    );

                    if (confirm == true) {
                      await authController.logout();
                      if (context.mounted) {
                        context.go('/auth');
                      }
                    }
                  },
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? textColor,
    Color? iconColor,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        leading: Icon(icon, color: iconColor ?? Colors.black87),
        title: Text(
          title,
          style: TextStyle(
            color: textColor ?? Colors.black87,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        onTap: onTap,
      ),
    );
  }
}
