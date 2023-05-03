import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/user_secure_storage.dart';

class AppControllerNotifer extends ChangeNotifier {
  bool authenticated = false;

  void setAuthentication(bool value, bool shouldNotify) {
    // we will set this value after check with fire base
    authenticated = value;
    if (shouldNotify) notifyListeners();
  }
}
