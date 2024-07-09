import 'package:flutter_regex/flutter_regex.dart';

class FormValidation {
  String? generalValidation(String? value, String? message) {
    if (value == null || value.isEmpty) {
      return message;
    }
    return null;
  }

  String? emailValidation(String? value, String? message) {
    if (value != null && !value.isEmail()) {
      return message;
    }
    return generalValidation(value, "Please enter your email");
  }

  String? dateValidation(String? date, String? message){
    if(date != null && !date.isDateTime()){
      return message;
    }
    return generalValidation(date, "Please enter the date");
  }

  String? retypePasswordValidation(String? password, String? retypedPassword){
    if(password!=null && retypedPassword!=null && password.compareTo(retypedPassword)!=0){
      return "Password does not match";
    }
    return generalValidation(retypedPassword, "Please retype the password");
  }
}
