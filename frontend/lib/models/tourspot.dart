// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Tourspot {
  String name;
  String manager_name;
  String contact;
  String email;
  String opening_time;
  String closing_time;
  String description;
  String address;
  String password;

  // Optional fields for the next page
  String entry_fee;
  String wifi;
  String parking;
  String food;
  String pool;
  String other_services;

  Tourspot({
    required this.name,
    required this.manager_name,
    required this.contact,
    required this.email,
    required this.opening_time,
    required this.closing_time,
    required this.description,
    required this.address,
    required this.password,
    required this.entry_fee,
    required this.wifi,
    required this.parking,
    required this.food,
    required this.pool,
    required this.other_services,
  });

  Tourspot copyWith({
    String? name,
    String? manager_name,
    String? contact,
    String? email,
    String? opening_time,
    String? closing_time,
    String? description,
    String? address,
    String? password,
    String? entry_fee,
    String? wifi,
    String? parking,
    String? food,
    String? pool,
    String? other_services,
  }) {
    return Tourspot(
      name: name ?? this.name,
      manager_name: manager_name ?? this.manager_name,
      contact: contact ?? this.contact,
      email: email ?? this.email,
      opening_time: opening_time ?? this.opening_time,
      closing_time: closing_time ?? this.closing_time,
      description: description ?? this.description,
      address: address ?? this.address,
      password: password ?? this.password,
      entry_fee: entry_fee ?? this.entry_fee,
      wifi: wifi ?? this.wifi,
      parking: parking ?? this.parking,
      food: food ?? this.food,
      pool: pool ?? this.pool,
      other_services: other_services ?? this.other_services,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'manager_name': manager_name,
      'contact': contact,
      'email': email,
      'opening_time': opening_time,
      'closing_time': closing_time,
      'description': description,
      'address': address,
      'password': password,
      'entry_fee': entry_fee,
      'wifi': wifi,
      'parking': parking,
      'food': food,
      'pool': pool,
      'other_services': other_services,
    };
  }

  factory Tourspot.fromMap(Map<String, dynamic> map) {
    return Tourspot(
      name: map['name'] as String,
      manager_name: map['manager_name'] as String,
      contact: map['contact'] as String,
      email: map['email'] as String,
      opening_time: map['opening_time'] as String,
      closing_time: map['closing_time'] as String,
      description: map['description'] as String,
      address: map['address'] as String,
      password: map['password'] as String,
      entry_fee: map['entry_fee'] as String,
      wifi: map['wifi'] as String,
      parking: map['parking'] as String,
      food: map['food'] as String,
      pool: map['pool'] as String,
      other_services: map['other_services'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Tourspot.fromJson(String source) =>
      Tourspot.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Tourspot(name: $name, manager_name: $manager_name, contact: $contact, email: $email, opening_time: $opening_time, closing_time: $closing_time, description: $description, address: $address, password: $password, entry_fee: $entry_fee, wifi: $wifi, parking: $parking, food: $food, pool: $pool, other_services: $other_services)';
  }

  @override
  bool operator ==(covariant Tourspot other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.manager_name == manager_name &&
        other.contact == contact &&
        other.email == email &&
        other.opening_time == opening_time &&
        other.closing_time == closing_time &&
        other.description == description &&
        other.address == address &&
        other.password == password &&
        other.entry_fee == entry_fee &&
        other.wifi == wifi &&
        other.parking == parking &&
        other.food == food &&
        other.pool == pool &&
        other.other_services == other_services;
  }

  // @override
  // int get hashCode {
  //   return name.hashCode ^
  //       manager_name.hashCode ^
  //       contact.hashCode ^
  //       email.hashCode ^
  //       opening_time.hashCode ^
  //       closing_time.hashCode ^
  //       description.hashCode ^
  //       address.hashCode ^
  //       password.hashCode ^
  //       entry_fee.hashCode ^
  //       wifi.hashCode ^
  //       parking.hashCode ^
  //       food.hashCode ^
  //       pool.hashCode ^
  //       other_services.hashCode;
  // }
}
