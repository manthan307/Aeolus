import 'package:aeolus/Screens/home.dart';
import 'package:aeolus/db/type.dart';
import 'package:aeolus/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

// Main entry point of the application.
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter(); // Initialize Hive for local storage.
  Hive.registerAdapter(TaskAdapter()); // Register Hive adapter for Task.
  await Hive.openBox<Task>("tasks"); // Open Hive box for tasks.
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform); // Initialize Firebase.
  runApp(const ProviderScope(
      child: MyApp())); // Run the app with Riverpod provider scope.
}

// Root widget of the application.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aeolus',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      theme: ThemeData(
          colorSchemeSeed: const Color(0xffd6d0f0)), // Set the theme color.
      home: const Home(), // Set the home screen.
    );
  }
}
