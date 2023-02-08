import 'package:flutter/cupertino.dart';
import '../model/program_model.dart';
import '../screen/detail_screen.dart';
import 'nu_thumb_card.dart';

class NuProgram extends StatelessWidget {
  const NuProgram({
    super.key,
    required this.program,
    required this.height,
  });

  final ProgramModel program;
  final double height;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => DetailScreen(
              program: program,
            ),
            fullscreenDialog: true,
          ),
        );
      },
      child: Column(
        children: [
          NuThumbCard(
            program: program,
            height: height,
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
