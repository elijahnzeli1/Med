// lib/screens/book_appointment_screen.dart
import 'package:flutter/material.dart';
import 'package:medconnected/models/appointment.dart';
import 'package:medconnected/providers/user_provider.dart';
import 'package:medconnected/screens/symptom_checker_screen.dart';
import 'package:medconnected/services/appointment_service.dart';
import 'package:provider/provider.dart';

class BookAppointmentScreen extends StatefulWidget {
  const BookAppointmentScreen({super.key});

  @override
  _BookAppointmentScreenState createState() => _BookAppointmentScreenState();
}

class _BookAppointmentScreenState extends State<BookAppointmentScreen> {
  final AppointmentService _appointmentService = AppointmentService();
  DateTime? _selectedDate;
  String? _selectedDoctor;
  DateTime? _selectedSlot;
  List<DateTime> _availableSlots = [];
  bool _isLoading = false;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _selectedSlot = null;
        _availableSlots = [];
      });
      _fetchAvailableSlots();
    }
  }

  Future<void> _fetchAvailableSlots() async {
    if (_selectedDate == null || _selectedDoctor == null) return;

    setState(() {
      _isLoading = true;
    });

    try {
      _availableSlots = await _appointmentService.getAvailableSlots(
        _selectedDoctor!,
        _selectedDate!,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Failed to fetch available slots: ${e.toString()}')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _bookAppointment() async {
    if (_selectedDate == null ||
        _selectedDoctor == null ||
        _selectedSlot == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select date, doctor, and time slot')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final userId = Provider.of<UserProvider>(context, listen: false).user!.id;
      final appointment = Appointment(
        id: '', // Will be set by Firestore
        userId: userId,
        doctorId: _selectedDoctor!,
        dateTime: _selectedSlot!,
        status: 'scheduled', doctorName: '', specialty: '',
      );

      await _appointmentService.bookAppointment(appointment);
      Navigator.of(context)
          .pop(true); // Return true to indicate successful booking
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to book appointment: ${e.toString()}')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Book Appointment')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Select Date', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () => _selectDate(context),
              child: Text(_selectedDate == null
                  ? 'Choose Date'
                  : '${_selectedDate!.toLocal()}'.split(' ')[0]),
            ),
            const SizedBox(height: 16),
            Text('Select Doctor', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            DropdownButton<String>(
              value: _selectedDoctor,
              hint: const Text('Choose Doctor'),
              isExpanded: true,
              items: const [
                DropdownMenuItem(value: 'smith_id', child: Text('Dr. Smith')),
                DropdownMenuItem(
                    value: 'johnson_id',
                    child: Text('Dr. Johnson')),
                // Add more doctors as needed
              ],
              onChanged: (value) {
                setState(() {
                  _selectedDoctor = value;
                  _selectedSlot = null;
                  _availableSlots = [];
                });
                _fetchAvailableSlots();
              },
            ),
            const SizedBox(height: 16),
            Text('Select Time Slot',
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            _isLoading
                ? const CircularProgressIndicator()
                : Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _availableSlots.map((slot) {
                      return ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _selectedSlot = slot;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _selectedSlot == slot
                              ? Theme.of(context).primaryColor
                              : null,
                        ),
                        child: Text(
                            '${slot.hour}:${slot.minute.toString().padLeft(2, '0')}'),
                      );
                    }).toList(),
                  ),
            const Spacer(),
            CustomButton(
              text: 'Book Appointment',
              onPressed: _bookAppointment,
              isLoading: _isLoading, label: '',
            ),
          ],
        ),
      ),
    );
  }
}
