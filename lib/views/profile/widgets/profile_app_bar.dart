import 'package:flutter/material.dart';

class ProfileAppBar extends StatelessWidget {
  final String name;
  final String email;
  final String? avatarUrl;
  final double expandedHeight;

  const ProfileAppBar({
    Key? key,
    required this.name,
    required this.email,
    this.avatarUrl,
    required this.expandedHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: expandedHeight,
      pinned: true,
      backgroundColor: Colors.blueAccent,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.blueAccent,
                Colors.lightBlue.withValues(alpha: 0.8),
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 40), // SafeArea padding offset

              // Profile Avatar
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 4),
                ),
                child: CircleAvatar(
                  radius: 55.0,
                  backgroundColor: Colors.white,
                  backgroundImage: avatarUrl != null
                      ? NetworkImage(avatarUrl!) as ImageProvider
                      : const AssetImage('assets/images/default_avatar.png'),
                  child: avatarUrl == null
                      ? const Icon(Icons.person, size: 50, color: Colors.grey)
                      : null,
                ),
              ),
              const SizedBox(height: 16.0),

              // User Name
              Text(
                name,
                style: const TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 4.0),

              // User Email
              Text(
                email,
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.white.withValues(alpha: 0.9),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}