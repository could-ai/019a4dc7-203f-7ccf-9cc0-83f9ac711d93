import 'package:flutter/material.dart';

class MoodModel extends ChangeNotifier {
  List<Map<String, String>> _moods = [];  // Temporary storage for mood entries

  List<Map<String, String>> get moods => _moods;

  void addMood(String emotion, String note) {
    _moods.add({'emotion': emotion, 'note': note, 'timestamp': DateTime.now().toString()});
    notifyListeners();
  }
}
