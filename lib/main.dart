import 'package:flutter/material.dart';
import 'package:medconnected/providers/appointment_provider.dart';
import 'package:medconnected/providers/consultation_provider.dart';
import 'package:medconnected/providers/theme_provider.dart';
import 'package:medconnected/providers/user_provider.dart';
import 'package:medconnected/themes/app_theme.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:medconnected/localizations/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await NotificationService().initialize();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => AppointmentProvider()),
        ChangeNotifierProvider(create: (_) => ConsultationProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class NotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    await _requestNotificationPermission();
    await _initializeNotificationServices();
  }

  Future<void> _requestNotificationPermission() async {
    final status = await Permission.notification.request();
    if (status.isGranted) {
      _showSnackBar('Notification permission granted');
    } else if (status.isDenied) {
      _showSnackBar('Notification permission denied');
    } else if (status.isPermanentlyDenied) {
      _showSnackBar('Notification permission permanently denied. Please enable in settings.');
      await openAppSettings();
    }
  }

  Future<void> _initializeNotificationServices() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    final DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) async {
        _showSnackBar('Notification tapped: ${response.payload}');
        // Navigate to a specific screen or perform any action
      },
    );
  }

  void onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) {
    // Handle the receipt of a local notification on iOS
    _showSnackBar('Received iOS notification: $title');
  }

  void _showSnackBar(String message) {
    // Note: This method needs to be called from a BuildContext
    // You might need to adjust how you show SnackBars based on your app's structure
    final messenger = GlobalKey<ScaffoldMessengerState>().currentState;
    if (messenger != null) {
      messenger.showSnackBar(SnackBar(content: Text(message)));
    }
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Widget _buildSplashScreen() {
    return Container(
      color: Colors.white,
      child: const Center(
        child: FlutterLogo(size: 100),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'MedConnect',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode:
              themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          home: _buildSplashScreen(),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''),
            Locale('es', ''),
          ],
        );
      },
    );
  }
}