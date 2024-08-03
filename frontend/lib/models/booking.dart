import 'dart:convert';

class BookSpot {
  int userId;
  DateTime date;
  int numberOfPeople;
  int subtotal;
  String? message;
  int tourspotId;

  BookSpot({
    required this.userId,
    required this.date,
    required this.numberOfPeople,
    required this.subtotal,
    this.message,
    required this.tourspotId,
  });

  BookSpot copyWith({
    int? userId,
    DateTime? date,
    int? numberOfPeople,
    int? subtotal,
    String? message,
    int? tourspotId,
  }) {
    return BookSpot(
      userId: userId ?? this.userId,
      date: date ?? this.date,
      numberOfPeople: numberOfPeople ?? this.numberOfPeople,
      subtotal: subtotal ?? this.subtotal,
      message: message ?? this.message,
      tourspotId: tourspotId ?? this.tourspotId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'date': date.toIso8601String(),
      'number_of_people': numberOfPeople,
      'subtotal': subtotal,
      'message': message,
      'tourspot_id': tourspotId,
    };
  }

  factory BookSpot.fromMap(Map<String, dynamic> map) {
    return BookSpot(
      userId: map['user_id'],
      date: DateTime.parse(map['date']),
      numberOfPeople: map['number_of_people'],
      subtotal: map['subtotal'],
      message: map['message'],
      tourspotId: map['tourspot_id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory BookSpot.fromJson(String source) =>
      BookSpot.fromMap(json.decode(source));

  @override
  String toString() {
    return 'BookSpot(userId: $userId, date: $date, '
        'numberOfPeople: $numberOfPeople, subtotal: $subtotal, '
        'message: $message, tourspotId: $tourspotId)';
  }
}
