import 'package:flutter/material.dart';
import 'package:todo_app_with_nodejs/login.dart';
import 'package:todo_app_with_nodejs/signup.dart';

import 'dashboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      routes: {
        "/" : (context) => LoginPage(),
        "/signup" : (context) => SignupPage(),
        "/login" : (context) => LoginPage(),
        '/dashboard': (context) => const DashboardPage(),
      },
    );
  }
}
