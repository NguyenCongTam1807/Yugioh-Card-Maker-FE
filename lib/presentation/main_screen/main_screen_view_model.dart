import 'package:flutter/cupertino.dart';

class MainScreenViewModel extends ChangeNotifier {
  int currentPageIndex = 0;

  void changePage(int newPage) {
    currentPageIndex = newPage;
    notifyListeners();
  }
}