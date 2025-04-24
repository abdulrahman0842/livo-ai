import 'package:flutter/material.dart';

class Utils {
  static errorSnackBar(BuildContext context, String message) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        backgroundColor: const Color.fromARGB(255, 153, 18, 9),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        content: Text(
          message,
          style: const TextStyle(
            fontSize: 17,
          ),
        )));
  }

  Future<dynamic> serverIpDialog(
      BuildContext context, TextEditingController controller, bool isNew) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Server IP Address"),
            content: TextField(
              controller: controller,
              decoration: const InputDecoration(
                  hintText: "http://127.0.0.1:5000",
                  labelText: "Server IP",
                  border: OutlineInputBorder()),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    // // ServerIpService().setIP(controller.text);
                    // isNew
                    //     ? Navigator.pushReplacement(
                    //         context,
                    //         MaterialPageRoute(
                    //             builder: (_) => const LiverTestForm()))
                    //     : Navigator.pop(context);
                  },
                  child: const Text("Change IP"))
            ],
          );
        });
  }
}
