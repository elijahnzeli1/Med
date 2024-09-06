// lib/models/emr.dart
import 'package:medconnected/models/prescription.dart';

class EMR {
  final String id;
  final String patientName;
  final String patientId;
  final List<String> medicalHistory;
  final List<String> allergies;
  final List<Prescription> prescriptions;

  EMR({
    required this.id,
    required this.patientName,
    required this.patientId,
    required this.medicalHistory,
    required this.allergies,
    required this.prescriptions,
  });

  factory EMR.fromJson(Map<String, dynamic> json) {
    return EMR(
      id: json['id'],
      patientName: json['patientName'],
      patientId: json['patientId'],
      medicalHistory: List<String>.from(json['medicalHistory']),
      allergies: List<String>.from(json['allergies']),
      prescriptions: (json['prescriptions'] as List)
          .map((p) => Prescription.fromJson(p))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'patientName': patientName,
      'patientId': patientId,
      'medicalHistory': medicalHistory,
      'allergies': allergies,
      'prescriptions': prescriptions.map((p) => p.toJson()).toList(),
    };
  }
}
