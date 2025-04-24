import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:liver_app/view/home_screen.dart';
import 'package:liver_app/view/auth/login_screen.dart';
import 'package:liver_app/services/auth_service.dart';
import 'package:liver_app/widgets/custom_elevated_button.dart';
import 'package:liver_app/widgets/custom_text_form_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers to access input values
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  String? _selectedGender;

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // print('Name: ${_nameController.text}');
      // print('Email: ${_emailController.text}');
      // print('Password: ${_passwordController.text}');
      // print('Age: ${_ageController.text}');
      // print('Gender: $_selectedGender');

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Signup successful')),
      );
    }
  }

  void _goToSignIn() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Register",
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: 100,
                  ),
                  const Text(
                    'Please Enter your details',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  const SizedBox(height: 32),
                  CustomTextFormField(
                      controller: _nameController, label: "Name"),
                  const SizedBox(height: 10),
                  CustomTextFormField(
                      controller: _emailController, label: "Email"),
                  const SizedBox(height: 10),
                  CustomTextFormField(
                      controller: _passwordController, label: "Password"),
                  const SizedBox(height: 10),
                  CustomTextFormField(controller: _ageController, label: "Age"),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: 100,
                    child: DropdownButtonFormField<String>(
                      decoration: const InputDecoration(labelText: 'Gender'),
                      value: _selectedGender,
                      items: ['Male', 'Female', 'Other']
                          .map((gender) => DropdownMenuItem(
                                value: gender,
                                child: Text(gender),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedGender = value;
                        });
                      },
                      validator: (value) =>
                          value == null ? 'Please select your gender' : null,
                    ),
                  ),
                  const SizedBox(height: 20),
                  CustomElevatedButton(
                    onPressed: () async {
                      UserCredential? user = await AuthService().signUp(
                          _emailController.text, _passwordController.text);
                      if (user != null) {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (_) => HomeScreen()));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Error: Invalid Credentials!")));
                      }
                    },
                    label: 'Sign up',
                  ),
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: _goToSignIn,
                    child: const Text(
                      "Already have an account? LogIn",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
