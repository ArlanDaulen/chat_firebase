import 'package:chat_firebase/core/c_colors.dart';
import 'package:chat_firebase/core/injection/configurator.dart';
import 'package:chat_firebase/feature/auth/auth_gate.dart';
import 'package:chat_firebase/firebase_messaging_service.dart';
import 'package:chat_firebase/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseMessagingService().init();
  await configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: CColors.background,
        primaryColor: CColors.primary,
        secondaryHeaderColor: CColors.secondary,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: CColors.primary,
          secondary: CColors.secondary,
          background: CColors.background,
          error: Colors.red,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: CColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: CColors.grey),
          bodyMedium: TextStyle(color: CColors.grey),
          bodySmall: TextStyle(color: CColors.grey),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: CColors.primary, width: 1.5),
          ),
          hintStyle: TextStyle(color: CColors.grey.withOpacity(0.6)),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: CColors.primary,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(foregroundColor: CColors.primary),
        ),
        iconTheme: const IconThemeData(color: CColors.primary),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: CColors.primary,
          foregroundColor: Colors.white,
        ),
      ),
      home: AuthGate(),
    );
  }
}
