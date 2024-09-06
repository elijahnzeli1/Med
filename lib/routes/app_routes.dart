import 'package:flutter/material.dart';
import 'package:medconnected/screens/appointment_screen.dart';
import 'package:medconnected/screens/consultation_screen.dart';
import 'package:medconnected/screens/emr_screen.dart';
import 'package:medconnected/screens/home_screen.dart';
import 'package:medconnected/screens/login_screen.dart';
import 'package:medconnected/screens/notifications_screen.dart';
import 'package:medconnected/screens/profile_screen.dart';
import 'package:medconnected/screens/signup_screen.dart';
import 'package:medconnected/screens/symptom_checker_screen.dart';

class AppRoutes {
  static const String initial = '/';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String home = '/home';
  static const String appointment = '/appointment';
  static const String consultation = '/consultation';
  static const String profile = '/profile';
  static const String emr = '/emr';
  static const String symptomChecker = '/symptom-checker';
  static const String notifications = '/notifications';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case initial:
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case signup:
        return MaterialPageRoute(builder: (_) => const SignupScreen());
      case appointment:
        return MaterialPageRoute(builder: (_) => const AppointmentScreen());
      case consultation:
        return MaterialPageRoute(builder: (_) => const ConsultationScreen());
      case profile:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      case emr:
        return MaterialPageRoute(builder: (_) => EMRScreen());
      case symptomChecker:
        return MaterialPageRoute(builder: (_) => const SymptomCheckerScreen());
      case notifications:
        return MaterialPageRoute(builder: (_) => NotificationsScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
