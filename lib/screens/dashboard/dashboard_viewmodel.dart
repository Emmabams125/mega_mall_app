import 'package:ecommerce_app/app/locator.dart';
import 'package:ecommerce_app/core/services/utility_service.dart';
import 'package:stacked/stacked.dart';

class DashboardViewModel extends IndexTrackingViewModel {

  final UtilityService _utilityService = locator<UtilityService>();

  bool _showMenu = false;
  bool get showMenu => _showMenu;
  bool get showNav => _utilityService.showNav;

  set showMenu(bool val) {
    _showMenu = val;
    notifyListeners();
  }

  @override
  List<ListenableServiceMixin> get listenableServices => [_utilityService];
}