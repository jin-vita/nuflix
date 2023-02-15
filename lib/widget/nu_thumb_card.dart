import 'package:flutter/material.dart';

import '../model/program_model.dart';

class NuThumbCard extends StatelessWidget {
  const NuThumbCard({
    super.key,
    required this.program,
    required this.height,
  });

  final ProgramModel program;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: program.id,
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              blurRadius: 15,
              offset: const Offset(10, 10),
              color: Colors.black.withOpacity(0.3),
            ),
          ],
        ),
        height: height,
        child: Image.asset('assets/images/${program.thumb}'),
      ),
    );
  }
}
