// import 'package:flutter/material.dart';
// import 'package:livoai_v02/services/api_service.dart';

// class HomeViewModel with ChangeNotifier {
//   bool _isLoading = false;
//   String? _error;
//   String? _result;

//   bool get isLoading => _isLoading;
//   String? get error => _error;
//   String? get result => _result;

//   final apiService = ApiService();
//   void detectDisease(Map<String, dynamic> data) async {
//     _result = null;
//     _error = null;
//     _isLoading = true;
//     notifyListeners();
//     try {
//       _result = await apiService.detectDisease(data);
//       _isLoading = false;
//       notifyListeners();
//     } catch (e) {
//       _error = e.toString();
//       _isLoading = false;
//       notifyListeners();
//     }
//     _isLoading = false;
//     notifyListeners();
//   }

//   void setDefaultAll() {
//     _isLoading = false;
//     _error = null;
//     _result = null;
//     notifyListeners();
//   }
// }
