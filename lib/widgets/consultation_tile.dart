import 'package:flutter/material.dart';
import 'package:medconnected/models/consultation.dart';

class ConsultationTile extends StatelessWidget {
  final Consultation consultation;
  final VoidCallback onTap;

  const ConsultationTile({
    super.key,
    required this.consultation,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(consultation.doctorName),
      subtitle: Text(consultation.status),
      trailing: const Icon(Icons.video_call),
      onTap: onTap,
    );
  }
}
