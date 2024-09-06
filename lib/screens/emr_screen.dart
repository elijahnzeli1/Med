// lib/screens/emr_screen.dart
import 'package:flutter/material.dart';
import 'package:medconnected/models/emr.dart';

class EMRScreen extends StatelessWidget {
  final EMR emr = EMR(
    id: '1',
    patientName: 'John Doe',
    patientId: '12345',
    medicalHistory: ['Hypertension', 'Type 2 Diabetes'],
    allergies: ['Penicillin'],
    prescriptions: [],
  );

  EMRScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Electronic Medical Record')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Patient: ${emr.patientName}',
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            Text('Medical History:',
                style: Theme.of(context).textTheme.titleMedium),
            ...emr.medicalHistory.map((item) => Text('• $item')),
            const SizedBox(height: 16),
            Text('Allergies:', style: Theme.of(context).textTheme.titleMedium),
            ...emr.allergies.map((item) => Text('• $item')),
            const SizedBox(height: 16),
            Text('Prescriptions:',
                style: Theme.of(context).textTheme.titleMedium),
            emr.prescriptions.isEmpty
                ? const Text('No active prescriptions')
                : Column(
                    children: emr.prescriptions
                        .map((p) => Text(p.toString()))
                        .toList()),
          ],
        ),
      ),
    );
  }
}
