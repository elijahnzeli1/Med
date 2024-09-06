import 'package:flutter/material.dart';
// import 'package:medconnect/widgets/custom_button.dart';

class SymptomCheckerScreen extends StatefulWidget {
  const SymptomCheckerScreen({super.key});

  @override
  _SymptomCheckerScreenState createState() => _SymptomCheckerScreenState();
}

class _SymptomCheckerScreenState extends State<SymptomCheckerScreen> {
  List<String> selectedSymptoms = [];

  final List<String> allSymptoms = [
    'Headache',
    'Fever',
    'Cough',
    'Fatigue',
    'Shortness of breath',
    'Nausea',
  ];

  void _checkSymptoms() {
    if (selectedSymptoms.isEmpty) {
      _showDialog(
          'No Symptoms Selected', 'Please select at least one symptom.');
      return;
    }

    String result = 'Based on your symptoms, ';
    if (selectedSymptoms.contains('Fever') &&
        selectedSymptoms.contains('Cough')) {
      result += 'you may have a cold or flu. ';
    } else {
      result +=
          'we recommend consulting with a doctor for further evaluation. ';
    }

    result += '\n\nSelected symptoms: ${selectedSymptoms.join(", ")}';

    _showDialog('Symptom Check Result', result);
  }

  void _showDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Symptom Checker')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: allSymptoms.length,
              itemBuilder: (context, index) {
                final symptom = allSymptoms[index];
                return CheckboxListTile(
                  title: Text(symptom),
                  value: selectedSymptoms.contains(symptom),
                  onChanged: (bool? value) {
                    setState(() {
                      if (value == true) {
                        selectedSymptoms.add(symptom);
                      } else {
                        selectedSymptoms.remove(symptom);
                      }
                    });
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomButton(
              label: 'Check Symptoms',
              onPressed: _checkSymptoms, isLoading: false, text: '',
            ),
          ),
        ],
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String label;
  final void Function() onPressed;

  const CustomButton({super.key, required this.label, required this.onPressed, required bool isLoading, required String text});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(label),
    );
  }
}
