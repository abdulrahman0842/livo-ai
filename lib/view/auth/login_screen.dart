import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:liver_app/view/home_screen.dart';
import 'package:liver_app/view/auth/signup_screen.dart';
import 'package:liver_app/services/auth_service.dart';
import 'package:liver_app/widgets/custom_elevated_button.dart';
import 'package:liver_app/widgets/custom_text_form_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _goToSignUp() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => SignUpScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white, // Black background
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text("Login",
                        style: TextStyle(
                            fontSize: 32, fontWeight: FontWeight.bold)),
                    const SizedBox(
                      height: 100,
                    ),
                    const Text(
                      'Please Enter your Account details',
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                    const SizedBox(height: 32),
                    CustomTextFormField(
                      controller: _emailController,
                      label: 'Email',
                    ),
                    const SizedBox(height: 20),
                    CustomTextFormField(
                        controller: _passwordController, label: "Password"),
                    const SizedBox(height: 10),
                    // Align(
                    //   alignment: Alignment.centerRight,
                    //   child: TextButton(
                    //     onPressed: () {}, // Add forgot password logic
                    //     child: const Text(
                    //       'Forgot Password',
                    //       style: TextStyle(color: Colors.black),
                    //     ),
                    //   ),
                    // ),
                    const SizedBox(height: 20),
                    CustomElevatedButton(
                      onPressed: () async {
                        UserCredential? user = await AuthService().signIn(
                            _emailController.text, _passwordController.text);
                        if (user != null) {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (_) => const HomeScreen()));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Error: Invalid Credentials!")));
                        }
                        // Future.delayed(Duration(seconds: 2)).then((_) {
                        //   Navigator.pushReplacement(context,
                        //       MaterialPageRoute(builder: (_) => HomeScreen()));
                        // });
                      },
                      label: "Login",
                    ),
                    const SizedBox(height: 12),
                    TextButton(
                      onPressed: _goToSignUp,
                      child: const Text(
                        "Don't have an account? Sign up",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
