class RestaurantAndRatings {
  final int id;
  final String restaurant_name;
  final String address;
  final String averageRating;
  final String? image;

  RestaurantAndRatings({
    required this.id,
    required this.restaurant_name,
    required this.address,
    required this.averageRating,
    this.image,
  });

  factory RestaurantAndRatings.fromJson(Map<String, dynamic> json) {
    return RestaurantAndRatings(
      id: json['id'],
      restaurant_name: json['restaurant_name'],
      address: json['address'],
      averageRating: json['average_rating'],
      image: json['image'],
    );
  }
}
