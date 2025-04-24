import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:liver_app/utils/colors.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key, required this.response});
  final Map<String, dynamic> response;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: backgroundColor,
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: primaryColor,
        title: const Text(
          "Result",
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Chip(
                  label: Text(
                    response["prediction"] == 0
                        ? "No Disease Detected"
                        : "Disease Detected",
                    style: const TextStyle(color: Colors.white),
                  ),
                  backgroundColor:
                      response["prediction"] == 0 ? Colors.green : Colors.red,
                ),
                Text(
                  response["prediction"] == 0
                      ? "No signs of liver disease detected."
                      : "Signs of Liver Disease Detected",
                  style: TextStyle(fontSize: 24),
                ),
                const Divider(),
                Text("Model Confidence: ${response["probability"]}",
                    style: const TextStyle(fontSize: 18)),
                const SizedBox(
                  height: 5,
                ),
                LinearProgressIndicator(
                  backgroundColor: Colors.white,
                  value: response["probability"] / 100,
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(12),
                  minHeight: 6,
                  semanticsLabel: "Confidence Level",
                  // semanticsValue: "80%",
                ),
                const Divider(),
                const Text("AI Recommendations:",
                    style: TextStyle(fontSize: 20)),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  elevation: 8,
                  color: Colors.grey.shade200,
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 10),
                      child: MarkdownBody(
                        data: response["llmResponse"],
                        styleSheet: MarkdownStyleSheet(
                          h1: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                          p: const TextStyle(fontSize: 16),
                          listBullet: const TextStyle(color: Colors.blue),
                        ),
                      )),
                ),
                const Divider(),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Expanded(
                //       child: ElevatedButton.icon(
                //           style: ElevatedButton.styleFrom(
                //               backgroundColor: primaryColor,
                //               foregroundColor: backgroundColor,
                //               iconColor: Colors.white,
                //               shape: RoundedRectangleBorder(
                //                 borderRadius: BorderRadius.circular(12),
                //               )),
                //           icon: const Icon(Icons.share),
                //           onPressed: () {},
                //           label: const Text("Share")),
                //     ),
                //     Expanded(
                //       child: ElevatedButton.icon(
                //           style: ElevatedButton.styleFrom(
                //               backgroundColor: primaryColor,
                //               foregroundColor: backgroundColor,
                //               iconColor: Colors.white,
                //               shape: RoundedRectangleBorder(
                //                 borderRadius: BorderRadius.circular(12),
                //               )),
                //           onPressed: () {},
                //           icon: const Icon(Icons.download),
                //           label: const Text("Download Report")),
                //     ),
                //   ],
                // ),
                // const Divider(),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  elevation: 8,
                  color: const Color.fromARGB(255, 241, 206, 206),
                  child: const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.info_outline),
                            SizedBox(
                              width: 5,
                            ),
                            Text("Disclaimer",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                            "This result is AI-generated based on your LFT values and general medical knowledge.\nPlease consult a licensed physician for accurate diagnosis and treatment.",
                            textAlign: TextAlign.justify,
                            style: TextStyle(fontSize: 16)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
