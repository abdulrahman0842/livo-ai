  import 'package:flutter/material.dart';

  class CustomTextFormField extends StatelessWidget {
    const CustomTextFormField({
      super.key,
      required this.controller,
      required this.label,
    });

    final TextEditingController controller;
    final String label;

    @override
    Widget build(BuildContext context) {
      return TextFormField(
        controller: controller,
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.black),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        validator: (value) => value!.isEmpty ? 'Please enter your $label' : null,
      );
    }
  }
