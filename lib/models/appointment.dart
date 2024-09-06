// lib/models/appointment.dart
class Appointment {
  final String id;
  final String doctorName;
  final String specialty;
  final DateTime dateTime;
  final String status;

  Appointment({
    required this.id,
    required this.doctorName,
    required this.specialty,
    required this.dateTime,
    required this.status, required String userId, required String doctorId,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      id: json['id'],
      doctorName: json['doctorName'],
      specialty: json['specialty'],
      dateTime: DateTime.parse(json['dateTime']),
      status: json['status'], userId: '', doctorId: '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'doctorName': doctorName,
      'specialty': specialty,
      'dateTime': dateTime.toIso8601String(),
      'status': status,
    };
  }

  static fromMap(Map<String, dynamic> data) {}

  Map<String, dynamic> toMap() {
    // Add a return statement here
    return {};
  }

  Future<Appointment> copyWith({required String id}) {
    // Add a return statement here
    return Future.value(this);
  }
}
