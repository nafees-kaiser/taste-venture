// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class RestaurantModel {
  String name;
  String email;
  String password;
  String address;
  String contact;
  String cuisine;
  String foodType;
  String openingTime;
  String closingTime;
  String description;
  String restaurantName;

  RestaurantModel({
    required this.name,
    required this.email,
    required this.password,
    required this.address,
    required this.contact,
    required this.cuisine,
    required this.foodType,
    required this.openingTime,
    required this.closingTime,
    required this.description,
    required this.restaurantName,
  });

  RestaurantModel copyWith({
    String? name,
    String? email,
    String? password,
    String? address,
    String? contact,
    String? cuisine,
    String? foodType,
    String? openingTime,
    String? closingTime,
    String? description,
    String? restaurantName,
  }) {
    return RestaurantModel(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      address: address ?? this.address,
      contact: contact ?? this.contact,
      cuisine: cuisine ?? this.cuisine,
      foodType: foodType ?? this.foodType,
      openingTime: openingTime ?? this.openingTime,
      closingTime: closingTime ?? this.closingTime,
      description: description ?? this.description,
      restaurantName: restaurantName ?? this.restaurantName,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'password': password,
      'address': address,
      'contact': contact,
      'cuisine': cuisine,
      'food_type': foodType,
      'opening_time': openingTime,
      'closing_time': closingTime,
      'description': description,
      'restaurant_name': restaurantName,
    };
  }

  factory RestaurantModel.fromMap(Map<String, dynamic> map) {
    return RestaurantModel(
      name: map['name'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      address: map['address'] as String,
      contact: map['contact'] as String,
      cuisine: map['cuisine'] as String,
      foodType: map['food_type'] as String,
      openingTime: map['opening_time'] as String,
      closingTime: map['closing_time'] as String,
      description: map['description'] as String,
      restaurantName: map['restaurant_name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory RestaurantModel.fromJson(String source) =>
      RestaurantModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'RestaurantModel(name: $name, email: $email, password: $password, address: $address, contact: $contact, cuisine: $cuisine, foodType: $foodType, openingTime: $openingTime, closingTime: $closingTime, description: $description, restaurantName: $restaurantName)';
  }

  @override
  bool operator ==(covariant RestaurantModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.name == name &&
      other.email == email &&
      other.password == password &&
      other.address == address &&
      other.contact == contact &&
      other.cuisine == cuisine &&
      other.foodType == foodType &&
      other.openingTime == openingTime &&
      other.closingTime == closingTime &&
      other.description == description &&
      other.restaurantName == restaurantName;
  }

  @override
  int get hashCode {
    return name.hashCode ^
      email.hashCode ^
      password.hashCode ^
      address.hashCode ^
      contact.hashCode ^
      cuisine.hashCode ^
      foodType.hashCode ^
      openingTime.hashCode ^
      closingTime.hashCode ^
      description.hashCode ^
      restaurantName.hashCode;
  }
}
