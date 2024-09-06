import 'package:flutter/material.dart';
import 'package:medconnected/providers/consultation_provider.dart';
import 'package:medconnected/providers/user_provider.dart';
import 'package:medconnected/services/consultation_service.dart';
import 'package:medconnected/widgets/consultation_tile.dart';
import 'package:provider/provider.dart';

class ConsultationScreen extends StatefulWidget {
  const ConsultationScreen({super.key});

  @override
  _ConsultationScreenState createState() => _ConsultationScreenState();
}

class _ConsultationScreenState extends State<ConsultationScreen> {
  final ConsultationService _consultationService = ConsultationService();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchConsultations();
  }

  Future<void> _fetchConsultations() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final userId = Provider.of<UserProvider>(context, listen: false).user!.id;
      final consultations = await _consultationService.getUpcomingConsultations(userId);
      Provider.of<ConsultationProvider>(context, listen: false).setConsultations(consultations);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch consultations: ${e.toString()}')),
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
      appBar: AppBar(title: const Text('Consultations')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Consumer<ConsultationProvider>(
              builder: (context, consultationProvider, child) {
                final consultations = consultationProvider.consultations;
                return consultations.isEmpty
                    ? const Center(child: Text('No upcoming consultations'))
                    : ListView.builder(
                        itemCount: consultations.length,
                        itemBuilder: (context, index) {
                          return ConsultationTile(
                            consultation: consultations[index],
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                '/consultation_details',
                                arguments: consultations[index],
                              );
                            },
                          );
                        },
                      );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/schedule_consultation');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}