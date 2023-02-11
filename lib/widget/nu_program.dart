import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../data.dart';
import '../model/program_model.dart';
import '../screen/detail_screen.dart';
import 'nu_thumb_card.dart';

class NuProgram extends StatelessWidget {
  const NuProgram({
    super.key,
    required this.program,
  });

  final ProgramModel program;

  @override
  Widget build(BuildContext context) {
    Data data = Provider.of(context);
    Future<void> goDetailScreen(context) async {
      await Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (context) => DetailScreen(
            program: program,
          ),
          fullscreenDialog: true,
        ),
      );
      data.applyData();
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
