import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:liver_app/services/database_service.dart';
import '../models/compositions_model.dart';

class ApiService {
  static const baseApi = 'http://127.0.0.1:5000/predict';

  Future<Map<String, dynamic>?> detectDisease(
    Map<String, dynamic> data,
  ) async {
    // String apiEndpoint = await ServerIpService().getIP() ?? '0';
    try {
      // log("Data: ${data.toString()}");
      CompositionModel model = CompositionModel().fromMap(data);
      // log("Json ${model.toJson().toString()}");
      // log("Json Encode ${jsonEncode(model.toJson())}");
      var response = await http.post(
        Uri.parse("http://192.168.90.136:3000/api/predict"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(model.toJson()),
      );
      log("Response: ${response.body.toString()}");
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        Map<String, dynamic> responseJson = {
          "llmResponse": json['llmResponse'],
          "prediction": json["prediction"],
          "probability": json["probability"]
        };
        // DatabaseService().addUserData(
        //     FirebaseAuth.instance.currentUser?.uid ?? "0", responseJson);
        return responseJson;
      }
    } catch (e) {
      log("Error:$e");

      // throw "Error: $e";
    }
    return null;
  }
}
