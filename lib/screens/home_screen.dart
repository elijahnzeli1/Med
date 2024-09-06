import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:medconnected/models/appointment.dart';
import 'package:medconnected/routes/app_routes.dart';
import 'package:medconnected/screens/symptom_checker_screen.dart';
import 'package:medconnected/widgets/appointment_card.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MedConnect'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () =>
                Navigator.pushNamed(context, AppRoutes.notifications),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: BootstrapContainer(
          fluid: true,
          children: [
            BootstrapRow(
              height: 100,
              children: [
                BootstrapCol(
                  sizes: 'col-12',
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Welcome, User!',
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                  ),
                ),
              ],
            ),
            BootstrapRow(
              height: 150,
              children: [
                BootstrapCol(
                  sizes: 'col-6',
                  child: CustomButton(
                    label: 'Book Appointment',
                    onPressed: () =>
                        Navigator.pushNamed(context, AppRoutes.appointment), isLoading: false, text: '',
                  ),
                ),
                BootstrapCol(
                  sizes: 'col-6',
                  child: CustomButton(
                    label: 'Start Consultation',
                    onPressed: () =>
                        Navigator.pushNamed(context, AppRoutes.consultation), isLoading: true, text: '',
                  ),
                ),
              ],
            ),
            BootstrapRow(
              height: 200,
              children: [
                BootstrapCol(
                  sizes: 'col-12',
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Upcoming Appointments',
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                          const SizedBox(height: 8),
                          AppointmentCard(
                            doctorName: 'Dr. John Doe',
                            specialty: 'Cardiologist',
                            dateTime:
                                DateTime.now().add(const Duration(days: 2)), appointment: Appointment(id: '', doctorName: '', specialty: '', dateTime: DateTime.now(), status: '', userId: '', doctorId: ''), onTap: () {  },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            BootstrapRow(
              height: 100,
              children: [
                BootstrapCol(
                  sizes: 'col-6',
                  child: CustomButton(
                    label: 'View EMR',
                    onPressed: () =>
                        Navigator.pushNamed(context, AppRoutes.emr),
                    isLoading: true,
                    text: 'Welcome, User!',
                  ),
                ),
                BootstrapCol(
                  sizes: 'col-6',
                  child: CustomButton(
                    label: 'Symptom Checker',
                    onPressed: () =>
                        Navigator.pushNamed(context, AppRoutes.symptomChecker), isLoading: true, text: 'Welcome, User!',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today), label: 'Appointments'),
          BottomNavigationBarItem(
              icon: Icon(Icons.chat), label: 'Consultations'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        currentIndex: 0,
        onTap: (index) {
          // Handle navigation
        },
      ),
    );
  }
}
