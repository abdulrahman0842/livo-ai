import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import '../services/text_service.dart';
import '../utils/utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _picker = ImagePicker();
  XFile? file;
  final textRecognizer = TextRecognizer();
  String recognizedText = '';
  Map<String,dynamic> extractedComposition = {};

  void _pickImage(bool fromCamera) async {
    XFile? image = await _picker.pickImage(
        source: fromCamera ? ImageSource.camera : ImageSource.gallery);
    if (image == null) return;
    setState(() {
      file = image;
    });
    
  }

  @override
  void dispose() {
    textRecognizer.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Livo AI")),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
                spacing: 10,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  file != null
                      ? Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: MediaQuery.of(context).size.height * 0.6,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: FileImage(File(file!.path)))),
                        )
                      : Container(),
                  ElevatedButton(
                      onPressed: () {
                        _pickImage(true);
                      },
                      child: Text('Pick Image from Camera')),
                  ElevatedButton(
                      onPressed: () {
                        _pickImage(false);
                      },
                      child: Text('Pick Image from Gallery')),
                  ElevatedButton(
                      onPressed: () {
                        if (file != null) {
                          extractedComposition =
                              TextService().extractCompositions(recognizedText);
                        } else {
                          Utils.errorSnackBar(
                              context, "Please pick an image first!!");
                        }
                      },
                      child: Text('Extract Compositions')),
                  // Text("Raw Text:$recognizedText"),
                  // Text("extractedComposition: $extractedComposition")
                ]),
          ),
        ));
  }
}
