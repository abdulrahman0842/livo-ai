import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import '../services/text_service.dart';
import '../utils/utils.dart';
import 'data_screen.dart';

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

  // This Function Pick an image and extracts data from it and return that text.
  void _pickImageAndExtractText(bool fromCamera) async {
    XFile? image = await _picker.pickImage(
        source: fromCamera ? ImageSource.camera : ImageSource.gallery);
    if (image == null) return;
    setState(() {
      file = image;
    });
    recognizedText = await TextService().recognizeText(image);
  }

  @override
  void dispose() {
    textRecognizer.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Livo AI"),
        actions: [IconButton(onPressed: (){
          // showDialog(context: context, builder:(context)=>AlertDialog())
        }, icon: Icon(Icons.add))],),
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
                        _pickImageAndExtractText(true);
                      },
                      child: Text('Pick Image from Camera')),
                  ElevatedButton(
                      onPressed: () {
                        _pickImageAndExtractText(false);
                      },
                      child: Text('Pick Image from Gallery')),
                  ElevatedButton(
                      onPressed: () {
                        getCompositions(context);
                      },
                      child: Text('Extract Compositions')),
                ]),
          ),
        ));
  }

  void getCompositions(BuildContext context) {
    if (file != null &&  recognizedText.isNotEmpty) {
      Map<String, dynamic> extractedComposition =
          TextService().extractCompositions(recognizedText);
      if (extractedComposition.isNotEmpty) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DataScreen(
                      data: extractedComposition,
                    )));
      }
    } else {
      Utils.errorSnackBar(context, "Please pick an image first!!");
    }
  }
}
