import 'package:flutter/material.dart';
import 'package:home_rental_application/views/profile/widgets/profile_app_bar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: CustomScrollView(
        slivers: [
          // Custom Sliver App Bar for the profile header
          const ProfileAppBar(
            name: "Dev Lucky",
            email: "devlucky@example.com",
            expandedHeight: 280.0,
          ),

          // Profile Menu Options
          SliverList(
            delegate: SliverChildListDelegate(
              [
                const SizedBox(height: 20),
                _buildProfileOption(icon: Icons.person_outline, title: "Edit Profile"),
                _buildProfileOption(icon: Icons.favorite_border, title: "Favorites"),
                _buildProfileOption(icon: Icons.settings_outlined, title: "Settings"),
                _buildProfileOption(icon: Icons.help_outline, title: "Help & Support"),
                const SizedBox(height: 20),
                _buildProfileOption(
                    icon: Icons.logout,
                    title: "Logout",
                    textColor: Colors.red,
                    iconColor: Colors.red
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper widget to build the list tiles for the profile menu
  Widget _buildProfileOption({
    required IconData icon,
    required String title,
    Color? textColor,
    Color? iconColor
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
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
        onTap: () {
          // Add navigation logic here
        },
      ),
    );
  }
}