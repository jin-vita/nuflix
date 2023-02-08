import 'package:flutter/material.dart';

class NuAppBar extends StatelessWidget with PreferredSizeWidget {
  const NuAppBar({super.key, required this.title, this.action});
  final List<Widget>? action;
  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 3,
      backgroundColor: Colors.white,
      foregroundColor: Colors.green,
      actions: action,
      centerTitle: true,
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(55);
}
