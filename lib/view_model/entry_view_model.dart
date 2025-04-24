import 'package:flutter/material.dart';

import '../services/api_service.dart';

class EntryViewModel with ChangeNotifier {
  bool _isLoading = false;
  String _error = '';
  Map<String, dynamic>? _result;

  bool get isLoading => _isLoading;
  String get error => _error;
  Map<String, dynamic>? get result => _result;

  final apiService = ApiService();

  Future detectDisease(Map<String, dynamic> data) async {
    _result = null;
    _isLoading = true;
    _error = '';
    notifyListeners();
    try {
      _result = await apiService.detectDisease(data);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }
}


//   Future detectDisease(Map<String, dynamic> data) async {
//     _result = null;
//     _isLoading = true;
//     _error = '';
//     notifyListeners();
//     try {
//       await Future.delayed(Duration(seconds: 3)).then((_) {
//         _result = {
//           "probability": 22,
//           "prediction": 1,
//           "llmResponse": "DATAHERE"
//         };
//       });
//       log("Test RE ${result.toString()}");
//       // _result = await apiService.detectDisease(data);
//       _isLoading = false;
//       notifyListeners();
//     } catch (e) {
//       _error = e.toString();
//       _isLoading = false;
//       notifyListeners();
//     }
//   }
// }
