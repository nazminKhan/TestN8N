import 'package:flutter/material.dart';
import 'package:mvvm_demo/utils/app_color.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool automaticallyImplyLeading;
  final List<Widget>? actions; // Add actions property

  const CustomAppBar({
    super.key,
    required this.title,
    this.automaticallyImplyLeading = false,
    this.actions, // Initialize actions
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: automaticallyImplyLeading,
      backgroundColor: AppColor.primary,
      iconTheme: const IconThemeData(
        color: Colors.white, // Set the color of the leading icon
      ),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      actions: actions, // Add actions to the AppBar
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}