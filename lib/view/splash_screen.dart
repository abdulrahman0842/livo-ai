import 'package:flutter/material.dart';
import 'package:livoai/services/server_ip_service.dart';
import 'package:livoai/utils/utils.dart';
import 'package:livoai/view/maunal_entry/liver_test_form_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final ipController = TextEditingController();
  void checkIP(BuildContext context) async {
    String? ip = await ServerIpService().getIP();
    if (ip != null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => LiverTestForm()));
    } else {
      Utils().serverIpDialog(context, ipController, true);
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3)).then((_) {
      if (mounted) {
        checkIP(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
              spacing: 20,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
            Container(
                height: MediaQuery.of(context).size.height * 0.2,
                width: MediaQuery.of(context).size.height * 0.2,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/images/logo.png')))),
            Text(
              "L I V O  A I",
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                  color: Colors.teal.shade400),
            )
          ])),
    );
  }
}
