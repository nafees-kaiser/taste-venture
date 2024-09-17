import 'dart:convert';

class Customer_response {
  int id;
  String full_name;
  String contact;
  String email;
  String dob;
  String address;
  String gender;
  String married;
  String password;

  Customer_response({
    required this.id,
    required this.full_name,
    required this.contact,
    required this.email,
    required this.dob,
    required this.address,
    required this.gender,
    required this.married,
    required this.password,
  });

  Customer_response copyWith({
    int? id,
    String? fullName,
    String? contact,
    String? email,
    String? dob,
    String? address,
    String? gender,
    String? married,
    String? password,
  }) {
    return Customer_response(
      id: id ?? this.id,
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
      'id': id,
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

  factory Customer_response.fromMap(Map<String, dynamic> map) {
    return Customer_response(
      id: map['id'] as int,
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

  factory Customer_response.fromJson(String source) =>
      Customer_response.fromMap(json.decode(source) as Map<String, dynamic>);
}
