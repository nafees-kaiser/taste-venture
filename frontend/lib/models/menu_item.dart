// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class MenuItem {
  final String name;
  final String cuisine;
  final String food_type;
  final String ingredients;
  final String description;
  // final String image;
  final String price;
  final String size;
  final String category;

  MenuItem({
    required this.name,
    required this.cuisine,
    required this.food_type,
    required this.ingredients,
    required this.description,
    // required this.image,
    required this.price,
    required this.size,
    required this.category,
  });

  MenuItem copyWith({
    String? name,
    String? cuisine,
    String? food_type,
    String? ingredients,
    String? description,
    // String? image,
    String? price,
    String? size,
    String? category,
  }) {
    return MenuItem(
      name: name ?? this.name,
      cuisine: cuisine ?? this.cuisine,
      food_type: food_type ?? this.food_type,
      ingredients: ingredients ?? this.ingredients,
      description: description ?? this.description,
      // image: image ?? this.image,
      price: price ?? this.price,
      size: size ?? this.size,
      category: category ?? this.category,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'cuisine': cuisine,
      'food_type': food_type,
      'ingredients': ingredients,
      'description': description,
      // 'image': image,
      'price': price,
      'size': size,
      'category': category,
    };
  }

  factory MenuItem.fromMap(Map<String, dynamic> map) {
    return MenuItem(
      name: map['name'] as String,
      cuisine: map['cuisine'] as String,
      food_type: map['food_type'] as String,
      ingredients: map['ingredients'] as String,
      description: map['description'] as String,
      // image: map['image'] as String,
      price: map['price'] as String,
      size: map['size'] as String,
      category: map['category'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory MenuItem.fromJson(String source) => MenuItem.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MenuItem(name: $name, cuisine: $cuisine, food_type: $food_type, ingredients: $ingredients, description: $description,  price: $price, size: $size, category: $category)';
  }

  @override
  bool operator ==(covariant MenuItem other) {
    if (identical(this, other)) return true;
  
    return 
      other.name == name &&
      other.cuisine == cuisine &&
      other.food_type == food_type &&
      other.ingredients == ingredients &&
      other.description == description &&
      // other.image == image &&
      other.price == price &&
      other.size == size &&
      other.category == category;
  }

  @override
  int get hashCode {
    return name.hashCode ^
      cuisine.hashCode ^
      food_type.hashCode ^
      ingredients.hashCode ^
      description.hashCode ^
      // image.hashCode ^
      price.hashCode ^
      size.hashCode ^
      category.hashCode;
  }
}
