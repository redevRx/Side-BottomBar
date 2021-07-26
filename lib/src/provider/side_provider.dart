import 'package:flutter/cupertino.dart';

class SideProvider extends ChangeNotifier {
  int _currentIndex = 0;
  int _nextIdnex = 0;
  int _oldIndex = 0;

  int get currentIndex => _currentIndex;
  int get nextIndex => _nextIdnex;
  int get oldIndex => _oldIndex;

  void onCurrentIndex(int index) {
    _currentIndex = index;

    //set old and next
    _nextIdnex = _currentIndex + 1;
    _oldIndex = _currentIndex == 0 ? 0 : _currentIndex - 1;

    notifyListeners();
  }
}
