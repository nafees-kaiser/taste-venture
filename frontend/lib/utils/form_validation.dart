class FormValidation {
  String? generalValidation(String? value, String? message) {
    if (value == null || value.isEmpty) {
      return message;
    }
    return null;
  }

  
}
