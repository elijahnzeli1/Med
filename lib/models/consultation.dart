// lib/models/consultation.dart
class Consultation {
  final String id;
  final String doctorName;
  final String patientName;
  final DateTime dateTime;
  final String type; // video, audio, or text
  final String status;

  Consultation({
    required this.id,
    required this.doctorName,
    required this.patientName,
    required this.dateTime,
    required this.type,
    required this.status,
  });

  factory Consultation.fromJson(Map<String, dynamic> json) {
    return Consultation(
      id: json['id'],
      doctorName: json['doctorName'],
      patientName: json['patientName'],
      dateTime: DateTime.parse(json['dateTime']),
      type: json['type'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'doctorName': doctorName,
      'patientName': patientName,
      'dateTime': dateTime.toIso8601String(),
      'type': type,
      'status': status,
    };
  }

  Consultation copyWith({required String status, required String id}) {
    return Consultation(
      id: id,
      status: status, doctorName: '', patientName: '', dateTime: DateTime.now(), type: '',
    );
  }
  
  factory Consultation.fromMap(Map<String, dynamic> map) {
    // Implement the logic to create a Consultation object from the map
  
    // ...
  
    return Consultation(
      id: map['id'],
      doctorName: map['doctorName'],
      patientName: map['patientName'],
      dateTime: DateTime.parse(map['dateTime']),
      type: map['type'],
      status: map['status'],
    );
  }

  Map<String, dynamic> toMap() {
    // Add your logic here to convert the Consultation object to a map
    // ...
    return {
      'id': id,
      'doctorName': doctorName,
      'patientName': patientName,
      'dateTime': dateTime.toIso8601String(),
      'type': type,
      'status': status,
    };
  }
}

