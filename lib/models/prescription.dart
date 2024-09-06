// lib/models/prescription.dart
class Prescription {
  final String id;
  final String patientName;
  final String doctorName;
  final DateTime date;
  final List<String> medications;

  Prescription({
    required this.id,
    required this.patientName,
    required this.doctorName,
    required this.date,
    required this.medications,
  });

  factory Prescription.fromJson(Map<String, dynamic> json) {
    return Prescription(
      id: json['id'],
      patientName: json['patientName'],
      doctorName: json['doctorName'],
      date: DateTime.parse(json['date']),
      medications: List<String>.from(json['medications']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'patientName': patientName,
      'doctorName': doctorName,
      'date': date.toIso8601String(),
      'medications': medications,
    };
  }
}
