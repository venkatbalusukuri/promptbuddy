import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:shared_preferences/shared_preferences.dart';
import 'models.dart';

class DataService {
  static final DataService _instance = DataService._internal();
  factory DataService() => _instance;
  DataService._internal();

  List<Category> categories = [];
  List<Prompt> prompts = [];
  late SharedPreferences _prefs;

  // Add ThemeMode tracking
  bool isDarkMode = true;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    
    // Default to dark mode
    isDarkMode = _prefs.getBool('isDarkMode') ?? true;

    final String response = await rootBundle.loadString('assets/data/prompts.json');
    final data = await json.decode(response);
    
    categories = (data['categories'] as List)
        .map((e) => Category.fromJson(e))
        .toList();
        
    prompts = (data['prompts'] as List)
        .map((e) => Prompt.fromJson(e))
        .toList();
  }

  Future<void> toggleTheme() async {
    isDarkMode = !isDarkMode;
    await _prefs.setBool('isDarkMode', isDarkMode);
  }

  List<Prompt> getPromptsForCategory(String categoryId) {
    return prompts.where((p) => p.categoryId == categoryId).toList();
  }
}
