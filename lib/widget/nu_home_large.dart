import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/program_model.dart';
import 'nu_program.dart';

class NuHomeLarge extends StatelessWidget {
  const NuHomeLarge({
    super.key,
    required this.programs,
    required this.prefs,
  });

  final List<ProgramModel> programs;
  final SharedPreferences prefs;

  @override
  Widget build(BuildContext context) {
    final List<ProgramModel> myPrograms = [];
    for (var program in programs) {
      if (prefs.getStringList('like')!.contains(program.id)) {
        myPrograms.add(program);
      }
    }

    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.only(
          top: 10,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                for (var program in programs)
                  NuProgram(
                    program: program,
                    height: 300,
                    prefs: prefs,
                  ),
              ],
            ),
            // const SizedBox(
            //   height: 40,
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   children: [
            //     for (var program in myPrograms)
            //       NuProgram(
            //         program: program,
            //         height: 200,
            //         prefs: prefs,
            //       ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
