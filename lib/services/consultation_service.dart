// lib/services/consultation_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medconnected/models/consultation.dart';

class ConsultationService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Consultation>> getUpcomingConsultations(String userId) async {
    try {
      final snapshot = await _firestore
          .collection('consultations')
          .where('userId', isEqualTo: userId)
          .where('status', whereIn: ['scheduled', 'in_progress'])
          .orderBy('dateTime')
          .get();

      return snapshot.docs
          .map((doc) => Consultation.fromMap(doc.data()))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch consultations: ${e.toString()}');
    }
  }

  Future<Consultation> scheduleConsultation(Consultation consultation) async {
    try {
      final docRef = await _firestore
          .collection('consultations')
          .add(consultation.toMap());
      return consultation.copyWith(id: docRef.id, status: '');
    } catch (e) {
      throw Exception('Failed to schedule consultation: ${e.toString()}');
    }
  }

  Future<void> startConsultation(String consultationId) async {
    try {
      await _firestore.collection('consultations').doc(consultationId).update({
        'status': 'in_progress',
        'startTime': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Failed to start consultation: ${e.toString()}');
    }
  }

  Future<void> endConsultation(String consultationId) async {
    try {
      await _firestore.collection('consultations').doc(consultationId).update({
        'status': 'completed',
        'endTime': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Failed to end consultation: ${e.toString()}');
    }
  }
}
