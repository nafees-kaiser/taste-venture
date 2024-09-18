import 'dart:convert';

class Reservation {
  int? id;
  int? userId;
  int? restaurantId;
  String? date;
  String? startTime;
  String? endTime;
  int? reservationType;
  int? numberOfPeople;
  String? message;
  String? status;

  Reservation({
    required this.userId,
    required this.restaurantId,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.reservationType,
    this.numberOfPeople,
    this.message,
    this.status,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user_id': userId,
      'restaurant_id': restaurantId,
      'date': date,
      'start_time': startTime,
      'end_time': endTime,
      'restaurant_type': reservationType,
      'number_of_people': numberOfPeople,
      'message': message,
      'status': status
    };
  }

  factory Reservation.fromMap(Map<String, dynamic> map) {
    return Reservation(
      userId: map['user_id'] as int,
      restaurantId: map['restaurant_id'] as int,
      date: map['date'] as String,
      startTime: map['start_time'] as String,
      endTime: map['end_time'] as String,
      reservationType: map['reservation_type'] as int,
      numberOfPeople: map['number_of_people'] as int,
      message: map['message'] as String,
      status: map['status'] as String
    );
  }

  String toJson() => json.encode(toMap());
}
