import 'package:aeolus/Screens/home.dart';
import 'package:aeolus/Screens/login.dart';
import 'package:aeolus/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ProviderScope(child: MyApp()));
}

final _routes = GoRouter(routes: [
  GoRoute(
    path: "/",
    builder: (context, state) => const Home(),
    // redirect: (BuildContext context, GoRouterState state) async {
    //   if (true) {
    //     return '/login';
    //   }
    // },
  ),
  GoRoute(
    path: "/login",
    builder: (context, state) => const LoginPage(),
  )
]);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Aeolus',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      routerConfig: _routes,
    );
  }
}
