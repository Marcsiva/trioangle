import 'package:flutter/cupertino.dart';
import 'package:trioangle/serviece/register_service.dart';

import '../model/register_model.dart';

class RegisterViewModel extends ChangeNotifier {
  late RegisterModel _model;

  RegisterModel get register => _model;

  final RegisterController _controller = RegisterController();

  void addData(String uid, String firstName, String lastName, String phone,
      String email, String password) {
    _model = RegisterModel(
        uid: uid,
        firstName: firstName,
        lastName: lastName,
        phone: phone,
        email: email,
        password: password);
    _controller.createRegister(_model);
  }

  validate(String value) {
    value = register.firstName;
    if (value.isEmpty) {
      return "Enter your first name";
    } else {
      return null;
    }
  }
}
