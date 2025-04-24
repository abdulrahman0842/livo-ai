// import 'package:flutter/material.dart';
// import 'package:livoai_v02/utils/data.dart';
// import 'package:livoai_v02/view_model/home_view_model.dart';
// import 'package:provider/provider.dart';

// class Home extends StatefulWidget {
//   const Home({super.key});

//   @override
//   State<Home> createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(body: Consumer<HomeViewModel>(builder: (context, value, _) {
//       if (value.error != null) {
//         return AlertDialog(
//           title: Text("Error"),
//           content: Text(value.error!),
//           actions: [
//             ElevatedButton(
//                 onPressed: () {
//                   value.setDefaultAll();
//                 },
//                 child: Text("OK"))
//           ],
//         );
//       }
//       if (value.isLoading) {
//         return Center(
//           child: CircularProgressIndicator(),
//         );
//       }

//       if (value.result != null) {
//         return AlertDialog(
//           title: Text("Result"),
//           content: Text(value.result!),
//           actions: [
//             ElevatedButton(
//                 onPressed: () {
//                   value.setDefaultAll();
//                 },
//                 child: Text("OK"))
//           ],
//         );
//       }
//       return Center(
//           child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         spacing: 20,
//         children: [
//           Text('LivoAIv02'),
//           ElevatedButton(
//               onPressed: () {
//                 value.detectDisease(lftData);
//               },
//               child: Text("Detect"))
//         ],
//       ));
//     }));
//   }
// }

import 'package:flutter/material.dart';
import 'package:liver_app/view/about_liver_screen.dart';
import 'package:liver_app/view/how_it_works_screen.dart';
import 'package:liver_app/view/liver_test_form_screen.dart';
import 'package:liver_app/utils/colors.dart';
import 'package:liver_app/utils/logo.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Column(
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.3,
              color: const Color(0xFF0A2455),
              child: Center(
                  child: Row(spacing: 25,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        image: DecorationImage(image: AssetImage(logoPath))),
                  ),
                  const Text(
                    "Livo AI",
                    style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  )
                ],
              )),
            ),
            const SizedBox(
              height: 25,
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                height: 50,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        foregroundColor: backgroundColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        )),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const LiverTestFormScreen()));
                    },
                    child: const Text(
                      "Enter LFT Report",
                    ))),
            const SizedBox(
              height: 25,
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                height: 50,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: secondaryColor,
                        foregroundColor: backgroundColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        )),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AboutLiverScreen()));
                    },
                    child: const Text(
                      "Know about Liver Disease",
                    ))),
            const SizedBox(
              height: 25,
            ),
            TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const HowItWorksPage()));
                },
                child: const Text("How it works? "))
          ],
        ),
        // Positioned(
        //   height: 110,
        //   right: 15,
        //   child: IconButton(
        //       onPressed: () {
        //         // AuthService().signOut();
        //         Future.delayed(const Duration(seconds: 2)).then((_) {
        //           Navigator.of(context).pushAndRemoveUntil(
        //             MaterialPageRoute(builder: (context) => const LoginPage()),
        //             (Route<dynamic> route) => false,
        //           );
        //         });
        //       },
        //       icon: const Icon(
        //         Icons.logout_outlined,
        //         color: Colors.white,
        //         size: 30,
        //       )),
        // ),
      ]),
    );
  }
}
