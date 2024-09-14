// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserEmail {
  String email;

  UserEmail({
    required this.email,
  });

  UserEmail copyWith({
    String? email,
  }) {
    return UserEmail(
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
    };
  }

  factory UserEmail.fromMap(Map<String, dynamic> map) {
    return UserEmail(
      email: map['email'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserEmail.fromJson(String source) =>
      UserEmail.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserEmail(email: $email)';
  }

  @override
  bool operator ==(covariant UserEmail other) {
    if (identical(this, other)) return true;

    return other.email == email;
  }

  @override
  int get hashCode {
    return email.hashCode;
  }
}
