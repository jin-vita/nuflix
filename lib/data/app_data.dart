import 'package:get/get.dart';
import 'package:nuflix/model/detail_model.dart';
import 'package:nuflix/model/episode_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/program_model.dart';

class AppData extends GetxController {
  List<ProgramModel> programs = [
    ProgramModel(
      title: '대탈출 시즌1',
      thumb: 'big1.jpg',
      id: 'eoxkfcnf1',
    ),
    ProgramModel(
      title: '대탈출 시즌2',
      thumb: 'big2.jpg',
      id: 'eoxkfcnf2',
    ),
    ProgramModel(
      title: '대탈출 시즌3',
      thumb: 'big3.jpg',
      id: 'eoxkfcnf3',
    ),
    ProgramModel(
      title: '대탈출 시즌4',
      thumb: 'big4.jpg',
      id: 'eoxkfcnf4',
    ),
  ];

  late List<EpisodeModel> episodes;
  late DetailModel detail;
  late ProgramModel program;

  late SharedPreferences prefs;

  AppData();

  void setProgram({program}) {
    this.program = program;
  }

  void setDetail({id}) {
    const String explain = '한 번 갇히면, 빠져나올 수 없다?!'
        '극한의 탈출 버라이어티. 그들이 믿을 거라곤.. 오직 동료들뿐! '
        '체력, 정신력, 근성, 재치, 두뇌.. 이 모든 것을 불살라 '
        '미스터리로 가득한 ‘초대형 밀실’을 탈출해야 한다! '
        '에피소드마다 새롭게 구현되는 테마와 밀실 공간! '
        '외부와 완벽히 차단된 이곳에서 '
        '빈틈투성이 여섯 멤버들은 과연 탈출 할 수 있을까?';

    switch (id) {
      case 'eoxkfcnf1':
        detail = DetailModel(
          title: '대탈출 시즌1',
          about: explain,
          genre: '리얼리티',
          birth: '2018',
        );
        episodes = [
          EpisodeModel(title: ' 1화 - 사설도박장 - 1 ', id: '586'),
          EpisodeModel(title: ' 2화 - 사설도박장 - 2 ', id: '587'),
          EpisodeModel(title: ' 3화 - 폐병원 - 1 ', id: '588'),
          EpisodeModel(title: ' 4화 - 폐병원 - 2 ', id: '589'),
          EpisodeModel(title: ' 5화 - 유전자 은행 - 1 ', id: '590'),
          EpisodeModel(title: ' 6화 - 유전자 은행 - 2, 악령 - 1 ', id: '591'),
          EpisodeModel(title: ' 7화 - 악령 감옥 - 2 ', id: '592'),
          EpisodeModel(title: ' 8화 - 악령 감옥 - 3 ', id: '593'),
          EpisodeModel(title: ' 9화 - 벙커 - 1 ', id: '594'),
          EpisodeModel(title: ' 10화 - 벙커 - 2 ', id: '595'),
          EpisodeModel(title: ' 11화 - 태양여고 - 1 ', id: '596'),
          EpisodeModel(title: ' 12화 - 태양여고 - 2 ', id: '597'),
          EpisodeModel(title: ' 13화 - 스페셜 편! ', id: '598'),
        ];
        break;
      case 'eoxkfcnf2':
        detail = DetailModel(
          title: '대탈출 시즌2',
          about: explain,
          genre: '리얼리티',
          birth: '2019',
        );
        episodes = [
          EpisodeModel(title: ' 1화 - 미래대학교 Ⅰ ', id: '599'),
          EpisodeModel(title: ' 2화 - 미래대학교 Ⅱ ', id: '600'),
          EpisodeModel(title: ' 3화 - 부암동 저택 Ⅰ ', id: '601'),
          EpisodeModel(title: ' 4화 - 부암동 저택 Ⅱ ', id: '612'),
          EpisodeModel(title: ' 5화 - 무간 교도소 Ⅰ ', id: '613'),
          EpisodeModel(title: ' 6화 - 무간 교도소 Ⅱ ', id: '604'),
          EpisodeModel(title: ' 7화 - 희망 연구소 Ⅰ ', id: '605'),
          EpisodeModel(title: ' 8화 - 희망 연구소 Ⅱ ', id: '606'),
          EpisodeModel(title: ' 9화 - 조 마테오 정신병원 Ⅰ ', id: '607'),
          EpisodeModel(title: ' 10화 - 조마테오 정신병원 Ⅱ ', id: '608'),
          EpisodeModel(title: ' 11화 - 살인감옥 Ⅰ ', id: '609'),
          EpisodeModel(title: ' 12화 - 살인감옥 Ⅱ ', id: '610'),
          EpisodeModel(title: ' 13화 - 시즌 Ⅱ Special ', id: '611'),
        ];
        break;
      case 'eoxkfcnf3':
        detail = DetailModel(
          title: '대탈출 시즌3',
          about: explain,
          genre: '리얼리티',
          birth: '2020',
        );
        episodes = [
          EpisodeModel(title: ' 1화 - 타임머신 연구실 1 ', id: '612'),
          EpisodeModel(title: ' 2화 - 타임머신 연구실 2 ', id: '613'),
          EpisodeModel(title: ' 3화 - 좀비 공장 1 ', id: '614'),
          EpisodeModel(title: ' 4화 - 좀비 공장 2 ', id: '615'),
          EpisodeModel(title: ' 5화 - 어둠의 별장 1 ', id: '616'),
          EpisodeModel(title: ' 6화 - 어둠의 별장 2 ', id: '617'),
          EpisodeModel(title: ' 7화 - 아차랜드 1 ', id: '618'),
          EpisodeModel(title: ' 8화 - 아차랜드 2 ', id: '619'),
          EpisodeModel(title: ' 9화 - 빵공장 1 ', id: '620'),
          EpisodeModel(title: ' 10화 - 빵공장 2 ', id: '622'),
          EpisodeModel(title: ' 11화 - 백 투 더 ㄱㅅ 1 ', id: '623'),
          EpisodeModel(title: ' 12화 - 백 투 더 ㄱㅅ 2 ', id: '624'),
          EpisodeModel(title: ' 13화 - 스페셜 ', id: '621'),
        ];
        break;
      case 'eoxkfcnf4':
        detail = DetailModel(
          title: '대탈출 시즌4',
          about: explain,
          genre: '리얼리티',
          birth: '2021',
        );
        episodes = [
          EpisodeModel(title: '대탈출 시즌 4 1화', id: '389'),
          EpisodeModel(title: '대탈출 시즌 4 2화', id: '22'),
          EpisodeModel(title: '대탈출 시즌 4 3화', id: '569'),
          EpisodeModel(title: '대탈출 시즌 4 4화', id: '682'),
          EpisodeModel(title: '대탈출 시즌 4 5화', id: '684'),
          EpisodeModel(title: '대탈출 시즌 4 6화', id: '1249'),
          EpisodeModel(title: '대탈출 시즌 4 7화', id: '1406'),
          EpisodeModel(title: '대탈출 시즌 4 8화', id: '1642'),
          EpisodeModel(title: '대탈출 시즌 4 9화', id: '1910'),
          EpisodeModel(title: '대탈출 시즌 4 10화', id: '2045'),
          EpisodeModel(title: '대탈출 시즌 4 11화', id: '2221'),
          EpisodeModel(title: '대탈출 시즌 4 12화', id: '2380'),
          EpisodeModel(title: '대탈출 시즌 4 13화', id: '12558'),
        ];
        break;
      default:
    }
  }
}
