import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../data/app_data.dart';
import '../model/program_model.dart';
import 'nu_thumb_card.dart';

class NuProgram extends StatelessWidget {
  const NuProgram({
    super.key,
    required this.program,
  });

  final ProgramModel program;

  @override
  Widget build(BuildContext context) {
    Future<void> goDetailScreen(context) async {
      Get.find<AppData>().program = program;
      Get.toNamed('/detail');
    }

    return GestureDetector(
      onTap: () async {
        await goDetailScreen(context);
      },
      child: Column(
        children: [
          NuThumbCard(
            program: program,
            height: 300,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            program.title,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
