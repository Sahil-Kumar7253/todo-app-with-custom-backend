import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
    Future<bool> isLoggedIn() async {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      return token != null && token.isNotEmpty;
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: FutureBuilder<bool>(
        future: isLoggedIn(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          return snapshot.data! ? DashboardPage() : LoginPage();
        },
      ),
      routes: {
        "/signup" : (context) => SignupPage(),
        "/login" : (context) => LoginPage(),
        '/dashboard': (context) => const DashboardPage(),
      },
    );
  }
}
