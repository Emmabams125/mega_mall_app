import 'package:stacked/stacked.dart';

class UtilityService with ListenableServiceMixin {

  bool _showNav = true;
  bool get showNav => _showNav;

  set showNav(bool value) {
    _showNav = value;
    notifyListeners();
  }

  UtilityService() {
    listenToReactiveValues([_showNav]);
  }
}