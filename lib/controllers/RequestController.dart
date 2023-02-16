import 'package:flutter/material.dart';

class RequestController extends ChangeNotifier {
  bool requestselected = false;
  String requeststatus = "Pending";

  void selectrequest() {
    requestselected = true;
    notifyListeners();
  }

  void unselectrequest() {
    requestselected = false;
    notifyListeners();
  }

  void acceptrequest() {
    requeststatus = "Accepted";
    notifyListeners();
  }

  void rejectrequest() {
    requeststatus = "Rejected";
    notifyListeners();
  }
}
