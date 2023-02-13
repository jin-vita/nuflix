import 'package:get/get.dart';

class User extends GetxController {
  Rx<String> name;
  late Rx<int> age;
  Rx<int> index = 0.obs;

  User({
    required this.name,
    required this.age,
  });

  void setData({name, age}) {
    this.name.value = name;
    this.age.value = age;
  }

  void setIndex({index}) {
    this.index.value = index;
    update();
  }

  void applyData({name, age}) {
    setData(
      name: name,
      age: age,
    );
    update();
  }
}
