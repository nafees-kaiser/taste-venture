import 'package:crypt/crypt.dart';

class PasswordHashing {
  String encryptPassword(String password) {
    return Crypt.sha512(password, salt: "").toString();
  }

  bool verifyPassword(String password, String hashedPassword){
    final h = Crypt(hashedPassword);
    return h.match(password);
  }
}
