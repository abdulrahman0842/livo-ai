import 'package:flutter/material.dart';
import 'package:livoai/services/api_service.dart';

class EntryViewModel with ChangeNotifier {
  bool _isLoading = false;
  String _error = '';
  String _result = '';

  bool get isLoading => _isLoading;
  String get error => _error;
  String get result => _result;

  final apiService = ApiService();

  Future detectDisease(Map<String, int> data) async {
    _isLoading = true;
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
