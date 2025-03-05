import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:livoai/services/server_ip_service.dart';

import '../models/compositions_model.dart';

class ApiService {
  static const baseApi = 'http://127.0.0.1:5000/predict';

  Future<String> detectDisease(
    Map<String, dynamic> data,
  ) async {
    String apiEndpoint = await ServerIpService().getIP() ?? '0';
    try {
      CompositionModel model = CompositionModel().fromMap(data);

      var response = await http.post(
        Uri.parse("$apiEndpoint/predict"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(model.toJson()),
      );

      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        return json["prediction"];
      }
    } catch (e) {
      log("Error:$e");

      return "error: $e";
    }
    return "0";
  }
}
