// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class RestaurantModel {
  String name;
  String email;
  String password;
  String address;
  String phone;
  String cuisine;
  String foodType;
  String openingTime;
  String closingTime;
  String description;

  RestaurantModel({
    required this.name,
    required this.email,
    required this.password,
    required this.address,
    required this.phone,
    required this.cuisine,
    required this.foodType,
    required this.openingTime,
    required this.closingTime,
    required this.description,
  });

  RestaurantModel copyWith({
    String? name,
    String? email,
    String? password,
    String? address,
    String? phone,
    String? cuisine,
    String? foodType,
    String? openingTime,
    String? closingTime,
    String? description,
  }) {
    return RestaurantModel(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      cuisine: cuisine ?? this.cuisine,
      foodType: foodType ?? this.foodType,
      openingTime: openingTime ?? this.openingTime,
      closingTime: closingTime ?? this.closingTime,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'password': password,
      'address': address,
      'phone': phone,
      'cuisine': cuisine,
      'foodType': foodType,
      'openingTime': openingTime,
      'closingTime': closingTime,
      'description': description,
    };
  }

  factory RestaurantModel.fromMap(Map<String, dynamic> map) {
    return RestaurantModel(
      name: map['name'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      address: map['address'] as String,
      phone: map['phone'] as String,
      cuisine: map['cuisine'] as String,
      foodType: map['foodType'] as String,
      openingTime: map['openingTime'] as String,
      closingTime: map['closingTime'] as String,
      description: map['description'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory RestaurantModel.fromJson(String source) =>
      RestaurantModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'RestaurantModel(name: $name, email: $email, password: $password, address: $address, phone: $phone, cuisine: $cuisine, foodType: $foodType, openingTime: $openingTime, closingTime: $closingTime, description: $description)';
  }

  @override
  bool operator ==(covariant RestaurantModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.email == email &&
        other.password == password &&
        other.address == address &&
        other.phone == phone &&
        other.cuisine == cuisine &&
        other.foodType == foodType &&
        other.openingTime == openingTime &&
        other.closingTime == closingTime &&
        other.description == description;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        email.hashCode ^
        password.hashCode ^
        address.hashCode ^
        phone.hashCode ^
        cuisine.hashCode ^
        foodType.hashCode ^
        openingTime.hashCode ^
        closingTime.hashCode ^
        description.hashCode;
  }
}
