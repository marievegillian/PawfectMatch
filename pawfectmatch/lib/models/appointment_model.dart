
class Appointment {
  final String user;
  final DateTime date;
  final String dog;
  final String status;

  Appointment({
    required this.user,
    required this.date,
    required this.dog,
    required this.status
  });

    factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      user: json['user'] ?? '',
      dog: json['dog'] ?? '',
      status: json['status'] ?? '',
      date: json['dateTime'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user,
      'dog': dog,
      'status': status,
      'dateTime': date,
    };
  }
}