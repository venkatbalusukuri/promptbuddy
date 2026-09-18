import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'data_service.dart';
import 'screens/categories_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb) {
    MobileAds.instance.initialize();
  }
  
  final dataService = DataService();
  await dataService.init();

  runApp(const PromptBuddyApp());
}

class PromptBuddyApp extends StatefulWidget {
  const PromptBuddyApp({super.key});

  @override
  State<PromptBuddyApp> createState() => _PromptBuddyAppState();
}

class _PromptBuddyAppState extends State<PromptBuddyApp> {
  final dataService = DataService();

  void _toggleTheme() async {
    await dataService.toggleTheme();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PromptBuddy',
      debugShowCheckedModeBanner: false,
      themeMode: dataService.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorSchemeSeed: Colors.deepPurple,
        fontFamily: 'Roboto',
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 0,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorSchemeSeed: Colors.deepPurple,
        fontFamily: 'Roboto',
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 0,
        ),
      ),
      home: CategoriesScreen(onThemeToggle: _toggleTheme),
    );
  }
}
