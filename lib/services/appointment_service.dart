// lib/services/appointment_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medconnected/models/appointment.dart';

class AppointmentService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Appointment>> getAppointments(String userId) async {
    try {
      final snapshot = await _firestore
          .collection('appointments')
          .where('userId', isEqualTo: userId)
          .get();

      return snapshot.docs
          .map((doc) => Appointment.fromMap(doc.data()) as Appointment)
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch appointments: ${e.toString()}');
    }
  }

  Future<Appointment> bookAppointment(Appointment appointment) async {
    try {
      final docRef =
          await _firestore.collection('appointments').add(appointment.toMap());
      return appointment.copyWith(id: docRef.id);
    } catch (e) {
      throw Exception('Failed to book appointment: ${e.toString()}');
    }
  }

  Future<void> cancelAppointment(String appointmentId) async {
    try {
      await _firestore.collection('appointments').doc(appointmentId).delete();
    } catch (e) {
      throw Exception('Failed to cancel appointment: ${e.toString()}');
    }
  }

  Future<List<DateTime>> getAvailableSlots(
      String doctorId, DateTime date) async {
    // This is a simplified implementation. In a real-world scenario,
    // you would need to check the doctor's schedule and existing appointments.
    try {
      final startOfDay =
          DateTime(date.year, date.month, date.day, 9, 0); // 9 AM
      final endOfDay = DateTime(date.year, date.month, date.day, 17, 0); // 5 PM

      final bookedSlots = await _firestore
          .collection('appointments')
          .where('doctorId', isEqualTo: doctorId)
          .where('dateTime', isGreaterThanOrEqualTo: startOfDay)
          .where('dateTime', isLessThan: endOfDay)
          .get();

      final bookedTimes = bookedSlots.docs
          .map((doc) => (doc.data()['dateTime'] as Timestamp).toDate())
          .toSet();

      final availableSlots = <DateTime>[];
      for (var i = 0; i < 16; i++) {
        // 30-minute slots from 9 AM to 5 PM
        final slotTime = startOfDay.add(Duration(minutes: 30 * i));
        if (!bookedTimes.contains(slotTime)) {
          availableSlots.add(slotTime);
        }
      }

      return availableSlots;
    } catch (e) {
      throw Exception('Failed to fetch available slots: ${e.toString()}');
    }
  }
}
