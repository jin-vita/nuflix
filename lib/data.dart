import 'package:flutter/cupertino.dart';

class Data extends ChangeNotifier {
  bool isHeart = false;

  void setData({isHeart}) {
    this.isHeart = isHeart;
  }

  void applyData({isHeart}) {
    setData(
      isHeart: isHeart,
    );
    notifyListeners();
  }
}
