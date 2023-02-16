import 'package:flutter/material.dart';

class NuAppBar extends StatelessWidget with PreferredSizeWidget {
  const NuAppBar({
    super.key,
    required this.title,
    this.actions,
    required this.hasIcon,
  });

  final List<Widget>? actions;
  final String title;
  final bool hasIcon;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: hasIcon,
      elevation: 3,
      backgroundColor: Colors.white,
      foregroundColor: Colors.cyan,
      actions: actions,
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
