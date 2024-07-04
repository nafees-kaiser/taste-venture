// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Customer {
  String full_name;
  String contact;
  String email;
  String dob;
  String address;
  String gender;
  String married;
  String password;

  Customer({
    required this.full_name,
    required this.contact,
    required this.email,
    required this.dob,
    required this.address,
    required this.gender,
    required this.married,
    required this.password,
  });

  Customer copyWith({
    String? fullName,
    String? contact,
    String? email,
    String? dob,
    String? address,
    String? gender,
    String? married,
    String? password,
  }) {
    return Customer(
      full_name: fullName ?? this.full_name,
      contact: contact ?? this.contact,
      email: email ?? this.email,
      dob: dob ?? this.dob,
      address: address ?? this.address,
      gender: gender ?? this.gender,
      married: married ?? this.married,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'full_name': full_name,
      'contact': contact,
      'email': email,
      'dob': dob,
      'address': address,
      'gender': gender,
      'married': married,
      'password': password,
    };
  }

  factory Customer.fromMap(Map<String, dynamic> map) {
    return Customer(
      full_name: map['full_name'] as String,
      contact: map['contact'] as String,
      email: map['email'] as String,
      dob: map['dob'] as String,
      address: map['address'] as String,
      gender: map['gender'] as String,
      married: map['married'] as String,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Customer.fromJson(String source) =>
      Customer.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Customer(fullName: $full_name, contact: $contact, email: $email, dob: $dob, address: $address, gender: $gender, married: $married, password: $password)';
  }

  @override
  bool operator ==(covariant Customer other) {
    if (identical(this, other)) return true;

    return other.full_name == full_name &&
        other.contact == contact &&
        other.email == email &&
        other.dob == dob &&
        other.address == address &&
        other.gender == gender &&
        other.married == married &&
        other.password == password;
  }

  @override
  int get hashCode {
    return full_name.hashCode ^
        contact.hashCode ^
        email.hashCode ^
        dob.hashCode ^
        address.hashCode ^
        gender.hashCode ^
        married.hashCode ^
        password.hashCode;
  }
}
