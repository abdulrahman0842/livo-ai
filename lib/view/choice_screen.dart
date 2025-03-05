import 'package:flutter/material.dart';
import 'package:livoai/view/home_screen.dart';
import 'package:livoai/widgets/custom_elevated_button.dart';

import 'maunal_entry/liver_test_form_screen.dart';

class ChoiceScreeb extends StatelessWidget {
  const ChoiceScreeb({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
          CustomElevatedButton(
            label: "Home",
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HomeScreen()));
            },
          ),
          CustomElevatedButton(
            label: "Choice",
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LiverTestForm()));
            },
          ),
        ])));
  }
}
