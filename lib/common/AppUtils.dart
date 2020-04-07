import 'package:email_validator/email_validator.dart';

class AppUtils {
  static bool isValidEmail(String email) {
    return EmailValidator.validate(email);
  }

  static isValidPassword(String password) {
    String  pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(password);
  }
}
