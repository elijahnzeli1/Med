// lib/models/symptom.dart

class Symptom {
  final String id;
  final String name;
  final String description;

  Symptom({
    required this.id,
    required this.name,
    required this.description,
  });
}

class Condition {
  final String id;
  final String name;
  final String description;
  final List<Symptom> associatedSymptoms;

  Condition({
    required this.id,
    required this.name,
    required this.description,
    required this.associatedSymptoms,
  });
}

class Recommendation {
  final String id;
  final String description;
  final RecommendationType type;

  Recommendation({
    required this.id,
    required this.description,
    required this.type,
  });
}

enum RecommendationType {
  selfCare,
  medication,
  doctorVisit,
  emergency,
}
