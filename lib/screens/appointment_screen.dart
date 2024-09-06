import 'package:flutter/material.dart';
import 'package:medconnected/providers/appointment_provider.dart';
import 'package:medconnected/providers/user_provider.dart';
import 'package:medconnected/services/appointment_service.dart';
import 'package:medconnected/widgets/appointment_card.dart';
import 'package:provider/provider.dart';


class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({super.key});

  @override
  _AppointmentScreenState createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  final AppointmentService _appointmentService = AppointmentService();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchAppointments();
  }

  Future<void> _fetchAppointments() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final userId = Provider.of<UserProvider>(context, listen: false).user!.id;
      final appointments = await _appointmentService.getAppointments(userId);
      Provider.of<AppointmentProvider>(context, listen: false)
          .setAppointments(appointments);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Failed to fetch appointments: ${e.toString()}')),
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
      appBar: AppBar(title: const Text('Appointments')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Consumer<AppointmentProvider>(
              builder: (context, appointmentProvider, child) {
                final appointments = appointmentProvider.appointments;
                return appointments.isEmpty
                    ? const Center(child: Text('No appointments scheduled'))
                    : ListView.builder(
                        itemCount: appointments.length,
                        itemBuilder: (context, index) {
                          return AppointmentCard(
                            appointment: appointments[index],
                            onTap: () {
                              // Navigate to appointment details screen
                            }, doctorName: '', dateTime: DateTime.now(), specialty: '',
                          );
                        },
                      );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/book_appointment');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
