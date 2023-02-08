import 'package:flutter/material.dart';
import '../model/program_model.dart';
import 'nu_program.dart';

class NuHomeLarge extends StatelessWidget {
  const NuHomeLarge({
    super.key,
    required this.programs,
  });

  final List<ProgramModel> programs;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          for (var program in programs)
            NuProgram(
              program: program,
              height: 300,
            ),
        ],
      ),
    );
  }
}
