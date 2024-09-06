// lib/screens/notifications_screen.dart
import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  final List<Map<String, String>> notifications = [
    {
      'title': 'Appointment Reminder',
      'message': 'You have an appointment with Dr. Smith tomorrow at 10:00 AM.'
    },
    {
      'title': 'New Message',
      'message':
          'You have a new message from Dr. Johnson regarding your last consultation.'
    },
    {
      'title': 'Prescription Ready',
      'message': 'Your prescription is ready for pickup at the pharmacy.'
    },
  ];

  NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notifications')),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(notifications[index]['title']!),
            subtitle: Text(notifications[index]['message']!),
            leading: const Icon(Icons.notifications),
            onTap: () {
              // TODO: Implement notification action
              // Add your code here to handle the notification action
              // For example, you can navigate to a new screen when the notification is tapped
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationDetailsScreen(notification: notifications[index])),
              );
            },
          );
        },
      ),
    );
  }
}

class NotificationDetailsScreen extends StatelessWidget {
  final Map<String, String> notification;

  const NotificationDetailsScreen({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    // Add your code here to build the notification details screen
    return Container();
  }
}
