import 'package:flutter/material.dart';
import 'package:medconnected/models/consultation.dart';

class ConsultationProvider extends ChangeNotifier {
  List<Consultation> _consultations = [];

  List<Consultation> get consultations => _consultations;

  void setConsultations(List<Consultation> consultations) {
    _consultations = consultations;
    notifyListeners();
  }

  void addConsultation(Consultation consultation) {
    _consultations.add(consultation);
    notifyListeners();
  }

  void updateConsultationStatus(String consultationId, String status) {
    final index = _consultations.indexWhere((c) => c.id == consultationId);
    if (index != -1) {
      _consultations[index] = _consultations[index].copyWith(status: status, id: '');
      notifyListeners();
    }
  }
}
