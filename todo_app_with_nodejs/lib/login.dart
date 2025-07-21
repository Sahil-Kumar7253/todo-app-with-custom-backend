import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Services/api_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  late var token1 = "";

  void _submitLogin() async {
    if (_formKey.currentState!.validate()) {
      final token = await ApiService.loginId(
        emailController.text,
        passwordController.text,
      );

      if (token != "") {
        final pref = await SharedPreferences.getInstance();
        await pref.setString("token", token);
        print(token);
        Navigator.pushNamedAndRemoveUntil(
          context,
          "/dashboard",
          (route) => false,
        );
      } else {
        print(token);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) =>
                    value!.contains('@') ? null : 'Enter a valid email',
              ),
              TextFormField(
                controller: passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) =>
                    value!.isEmpty ? 'Enter your password' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitLogin,
                child: const Text('Login'),
              ),
              TextButton(
                onPressed: () => Navigator.pushNamed(context, '/signup'),
                child: const Text('Don\'t have an account? Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
