import 'package:flutter/widgets.dart';
import 'package:sigevi_1/models/user.dart';
import 'package:sigevi_1/resources/auth_helper.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  final AuthMethods _authMethods = AuthMethods();
  
  

  User get getUser => _user!;

  Future<void> refreshUser() async {
    User user = await _authMethods.getUserDetails();
    _user = user;
    notifyListeners();
  }
  
}