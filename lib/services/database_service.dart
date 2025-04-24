import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addUserData(String userId, Map<String, dynamic> data) async {
    try {
      await _firestore
          .collection("users")
          .doc(userId)
          .collection("history")
          .doc(DateTime.now().toString())
          .set(data);
    } catch (e) {
      log("Error: $e");
    }
  }
}
