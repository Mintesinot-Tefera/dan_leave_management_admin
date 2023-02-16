import 'package:admin/screens/add_new_employee.dart';
import 'package:admin/screens/declined_requests.dart';
import 'package:admin/screens/pending_requests.dart';
import 'package:admin/screens/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';
import '../screens/approved_requests.dart';

class MenuController extends ChangeNotifier {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  late Widget _currentScreen = DashboardScreen();
  Widget get currentScreen => _currentScreen;
  set currentScreen(Widget newScreen) {
    _currentScreen = newScreen;
    notifyListeners();
  }

  void controlMenu() {
    if (!_scaffoldKey.currentState!.isDrawerOpen) {
      _scaffoldKey.currentState!.openDrawer();
    }
  }

  void changeCurrentScreen(CustomScreensEnum screen) {
    switch (screen) {
      case CustomScreensEnum.dashboardScreen:
        currentScreen = DashboardScreen();
        break;
      case CustomScreensEnum.pendingRequestScreen:
        currentScreen = PendingRequests();
        break;
      case CustomScreensEnum.approvedRequestScreen:
        currentScreen = ApprovedRequests();
        break;
      case CustomScreensEnum.declinedRequestScreen:
        currentScreen = DeclinedRequests();
        break;
      case CustomScreensEnum.addNewEmployeeScreen:
        currentScreen = AddNewEmployee(
          uid: '',
        );
        break;
      // case CustomScreensEnum.approvalScreen:
      //   currentScreen = RequestApprovalPage(
      //     empname: '',
      //     reqtype: '',
      //     description: '',
      //     startdate: '',
      //     applicationtimeanddate: '',
      //     enddate: '',
      //     status: '',
      //   );
      //   // StorageInfoCard(
      //   //   amountOfFiles: '',
      //   //   numOfFiles: 4,
      //   //   title: 'Mintesinot',
      //   // );
      //   break;
      // default:
      //   currentScreen = PendingRequests(
      //     requestselected: false,
      //   );
      //   break;
    }
  }
}

enum CustomScreensEnum {
  dashboardScreen,
  pendingRequestScreen,
  approvedRequestScreen,
  declinedRequestScreen,
  addNewEmployeeScreen,
  approvalScreen
}
