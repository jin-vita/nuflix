import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/program_model.dart';
import 'nu_program.dart';

class NuHomeSmall extends StatelessWidget {
  const NuHomeSmall({
    super.key,
    required this.programs,
    required this.prefs,
  });

  final List<ProgramModel> programs;
  final SharedPreferences prefs;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(
        horizontal: 30,
        vertical: 10,
      ),
      itemCount: programs.length,
      itemBuilder: (context, index) {
        var program = programs[index];
        return NuProgram(
          program: program,
          height: 300,
          prefs: prefs,
        );
      },
      separatorBuilder: (context, index) => const SizedBox(
        width: 30,
      ),
    );
  }
}
