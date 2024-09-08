class RestaurantAndRatings {
  final int id;
  final String name;
  final String address;
  final String averageRating;

  RestaurantAndRatings({
    required this.id,
    required this.name,
    required this.address,
    required this.averageRating,
  });

  factory RestaurantAndRatings.fromJson(Map<String, dynamic> json) {
    return RestaurantAndRatings(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      averageRating: json['average_rating'],
    );
  }
}
