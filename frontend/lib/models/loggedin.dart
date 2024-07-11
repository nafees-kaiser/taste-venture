// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Loggedin {
  String email;
  String password;

  Loggedin({
    required this.email,
    required this.password,
  });

  Loggedin copyWith({
    String? email,
    String? password,
  }) {
    return Loggedin(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'password': password,
    };
  }

  factory Loggedin.fromMap(Map<String, dynamic> map) {
    return Loggedin(
      email: map['email'] as String,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Loggedin.fromJson(String source) =>
      Loggedin.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Loggedin(email: $email, password: $password)';
  }

  @override
  bool operator ==(covariant Loggedin other) {
    if (identical(this, other)) return true;

    return other.email == email && other.password == password;
  }

  @override
  int get hashCode {
    return email.hashCode ^ password.hashCode;
  }
}
