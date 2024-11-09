import 'package:aeolus/Screens/home.dart';
import 'package:aeolus/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aeolus',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: const Color(0xff8ebbff),
        appBarTheme: const AppBarTheme(backgroundColor: Color(0xff24293e)),
        cardColor: const Color(0xff2f3651),
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.dark,
      home: const Home(),
    );
  }
}
