import 'dart:developer';
import 'dart:io';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';

class TextService {
  final TextRecognizer textRecognizer = TextRecognizer();

  Future<String> recognizeText(XFile image) async {
    final RecognizedText recognizedText = await textRecognizer
        .processImage(InputImage.fromFile(File(image.path)));

    log("Extracted Text (RAW): ${recognizedText.text}");
    List<String> lines = [];
    for (TextBlock block in recognizedText.blocks) {
      for (TextLine line in block.lines) {
        lines.add(line.text.trim());
      }
    }
    log("LINES of TEXT: $lines");
    return recognizedText.text;
  }

  Map<String, dynamic> extractCompositions(String text) {
/* 
  (\b \w+ \b) : \b-\b it captures whole word - \w+ it captues any word
  \s          : it captures one space - \s* it captures one or more spaces
  [-=:>]      : it captures any of these characters
  \d          : it captures any digit - \d+ it captures one or more digits  (it do not captures decimal points only whole number)
  \.          : it captures decimacal symbol
  (\.\d+)     : it captures decimal points and one or more digits
  ?           : it makes it's preceeding pattern optional 

                  ((\b\w+\b)\s*[-=:>]\s*(\d+(\.\d+)?))
  (\b\w+\b)      : it will captues words like SGPT, SGOT, Protein, Albumin etc
  \s*            : it will capture whitespaces
  [-=:>]?        : it will capture these symbols which are optional maybe possible there is no symbol used in lab report
  (\d+(\.\d+)?)) : it will capture level of compositions like 4.5, 84.5 259.3, 45 etc (and decimal capture is optional bcz some don't have decimal points)
*/

    RegExp generalPattern =
        RegExp(r"((\b\w+\s*\w+\b)\s*[-=:>]?\s*(\d+(\.\d+)?))");

    List<Match> matches = generalPattern.allMatches(text).toList();
    List<String> compositions =
        matches.map((match) => match.group(0)!).toList();
    // List<String> keys = matches.map((match) => match.group(3)!).toList();
    // log(keys.toString());
    for (var item in compositions) {
      log("- $item");
    }
    return mapOfComposition(compositions);
  }

//   Map<String, dynamic> extractCompositionsGpt(String text) {
//     RegExp pattern = RegExp(r"([\w\s&]+?)\s*[-=:>]\s*(\d+(\.\d+)?)");

//     Map<String, dynamic> extractedData = {};

//     for (Match match in pattern.allMatches(text)) {
//       String key = match.group(1)?.trim() ?? "";
//       String value = match.group(2) ?? "0";

//       if (key.isNotEmpty) {
//         extractedData[key] = double.tryParse(value) ?? value;
//       }
//     }

//     log("Extracted Compositions: $extractedData");
//     return extractedData;
//   }
// }

  Map<String, dynamic> mapOfComposition(List<String> compositions) {
   
    Map<String, dynamic> data = {};
    RegExp getName = RegExp(r"(\b\w+\b)");
    RegExp getLevel = RegExp(r"(\d+(\.\d+)?)");
    for (var item in compositions) {
      data.addAll(
          {getName.stringMatch(item).toString(): getLevel.stringMatch(item)});
    }
    log(data.toString());
    return data;
  }
}
