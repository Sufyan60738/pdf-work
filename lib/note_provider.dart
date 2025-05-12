/*
import 'package:flutter/foundation.dart';
import '../helper.dart';

class NoteProvider with ChangeNotifier {
  final List<Map<String, String>> _notes = [
    {"title": "Chapter 1 - Algebra", "file": "Android_Java.pdf"},
  ];

  String? _selectedPdfPath;

  List<Map<String, String>> get notes => _notes;

  String? get selectedPdfPath => _selectedPdfPath;

  Future<void> selectNote(String assetPath, String fileName) async {
    _selectedPdfPath = await fromAsset(assetPath, fileName);
    notifyListeners();
  }
}
*/

import 'package:flutter/foundation.dart';
import '../helper.dart';

class NoteProvider with ChangeNotifier {
  final List<Map<String, String>> _notes = [
    {"title": "Chapter 1 - Algebra", "file": "Android_Java.pdf"},
    {"title": "Chapter 2 - Algebra", "file": "cs614.pdf"},
  ];

  String? _selectedPdfPath;
  int _currentPage = 0;
  int _totalPages = 0;

  List<Map<String, String>> get notes => _notes;
  String? get selectedPdfPath => _selectedPdfPath;
  int get currentPage => _currentPage;
  int get totalPages => _totalPages;

  Future<void> selectNote(String assetPath, String fileName) async {
    _selectedPdfPath = await fromAsset(assetPath, fileName);
    _currentPage = 0;
    _totalPages = 0;
    notifyListeners();
  }

  void setPageInfo(int current, int total) {
    _currentPage = current;
    _totalPages = total;
    notifyListeners();
  }
}
