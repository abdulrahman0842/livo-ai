import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../models/compositions_model.dart';

class ApiService {
  static const baseApi = 'http://127.0.0.1:5000/predict';

  Future<void> predictDisease(Map<String, dynamic> data,String apiEndpoint) async {
    try {
      CompositionModel model = CompositionModel().fromMap(data);

      var response = await http.post(Uri.parse("$apiEndpoint/predict"),
          body: jsonEncode(model.toJson()),
          );

      if (response.statusCode == 200) {
        log("Success");
        log(response.body);
      }
    } catch (e) {log("Error:$e");}
  }
}
