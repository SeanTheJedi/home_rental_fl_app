import 'package:flutter/material.dart';
import '../../constants/color_constants.dart';

class PageLayout extends StatelessWidget {
  final String title;
  final Widget body;
  final List<Widget>? actions;

  const PageLayout({
    super.key,
    required this.title,
    required this.body,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        centerTitle: false,
        elevation: 0,
        title: Text(
          title,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: actions,
      ),
      body: SafeArea(
        child: body,
      ),
    );
  }
}