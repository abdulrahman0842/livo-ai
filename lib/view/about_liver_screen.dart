import 'package:flutter/material.dart';
import 'package:liver_app/utils/about_liver.dart';

class AboutLiverScreen extends StatelessWidget {
  const AboutLiverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "🩺 Know About Liver Disease",
            style: TextStyle(fontSize: 25),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 12),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    children: List.generate(aboutLiverInfo.length, (index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomCardWidget(
                          title: aboutLiverInfo[index]["title"] ?? "N/A",
                          description:
                              aboutLiverInfo[index]["content"] ?? "N/A",
                          icon: aboutLiverInfo[index]["icon"] ??
                              Icons.info_outline,
                        ),
                      );
                    }),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}

class CustomCardWidget extends StatelessWidget {
  const CustomCardWidget({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
  });
  final String title;
  final String description;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: Colors.teal.shade50,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                textAlign: TextAlign.justify,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Divider(
                color: Colors.grey,
                thickness: 0.8,
              ),
              Text(
                description,
                textAlign: TextAlign.justify,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              )
            ],
          ),
        ),
      ),
    );
  }
}
