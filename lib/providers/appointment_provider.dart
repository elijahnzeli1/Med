import 'package:flutter/material.dart';
import 'package:medconnected/models/appointment.dart';

class AppointmentProvider extends ChangeNotifier {
  List<Appointment> _appointments = [];

  List<Appointment> get appointments => _appointments;

  void setAppointments(List<Appointment> appointments) {
    _appointments = appointments;
    notifyListeners();
  }

  void addAppointment(Appointment appointment) {
    _appointments.add(appointment);
    notifyListeners();
  }

  void removeAppointment(String appointmentId) {
    _appointments.removeWhere((appointment) => appointment.id == appointmentId);
    notifyListeners();
  }
}
