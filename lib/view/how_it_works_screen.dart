import 'package:flutter/material.dart';

class HowItWorksPage extends StatelessWidget {
  const HowItWorksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("How It Works"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          SectionHeader(title: "Step-by-Step Process"),
          StepItem(
              step: "1",
              title: "Enter LFT Values",
              subtitle: "You provide your liver test values securely."),
          StepItem(
              step: "2",
              title: "AI Analysis",
              subtitle: "Our model checks for abnormal patterns."),
          StepItem(
              step: "3",
              title: "Detection & Confidence",
              subtitle: "We provide a risk score with explanation."),
          StepItem(
              step: "4",
              title: "AI Health Tips",
              subtitle: "Get personalized precautions from AI assistant."),
          SizedBox(height: 24),
          SectionHeader(title: "How Our AI Works"),
          InfoCard(
            text:
                "We use a deep learning model trained on liver reports. It analyzes LFT data and predicts potential liver issues. This tool helps in early awareness, not diagnosis.",
          ),
          SizedBox(height: 24),
          SectionHeader(title: "What Data We Use"),
          InfoCard(
            text:
                "• ALT (SGPT)\n• AST (SGOT)\n• Bilirubin (Total/Direct)\n• ALP\n• Albumin\n• Globulin\nThese values are used temporarily for prediction only.",
          ),
          SizedBox(height: 24),
          SectionHeader(title: "Privacy & Data Security"),
          InfoCard(
            text:
                "• Your data is processed securely.\n• No personal information is stored.\n• You can clear data anytime.\n• Encrypted processing is used for safety.",
          ),
          SizedBox(height: 24),
          SectionHeader(title: "Disclaimer"),
          InfoCard(
            text:
                "This tool does not replace a medical professional. Always consult a certified doctor for diagnosis and treatment.",
          ),
        ],
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;

  const SectionHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.teal.shade700,
          ),
    );
  }
}

class StepItem extends StatelessWidget {
  final String step;
  final String title;
  final String subtitle;

  const StepItem({
    super.key,
    required this.step,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.teal,
        child: Text(step, style: const TextStyle(color: Colors.white)),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(subtitle),
    );
  }
}

class InfoCard extends StatelessWidget {
  final String text;

  const InfoCard({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          text,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
    );
  }
}
