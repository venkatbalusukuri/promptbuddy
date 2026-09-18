import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../data_service.dart';
import '../models.dart';
import 'prompt_list_screen.dart';

class CategoriesScreen extends StatefulWidget {
  final VoidCallback onThemeToggle;
  const CategoriesScreen({super.key, required this.onThemeToggle});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final dataService = DataService();

  IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'person': return Icons.person;
      case 'landscape': return Icons.landscape;
      case 'shopping_bag': return Icons.shopping_bag;
      case 'brush': return Icons.brush;
      default: return Icons.category;
    }
  }

  void _onCategoryTapped(Category category) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PromptListScreen(category: category),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PromptBuddy', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: Icon(dataService.isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: widget.onThemeToggle,
          ),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.85,
        ),
        itemCount: dataService.categories.length,
        itemBuilder: (context, index) {
          final category = dataService.categories[index];
          // Use a simple prompt for the category background
          final String bgUrl = 'https://image.pollinations.ai/prompt/${Uri.encodeComponent(category.name)}?width=400&height=400&nologo=true';

          return GestureDetector(
            onTap: () => _onCategoryTapped(category),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              clipBehavior: Clip.antiAlias,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    bgUrl,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        color: Colors.deepPurple.shade900,
                        child: const Center(
                          child: CircularProgressIndicator(color: Colors.white54),
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) => Container(color: Colors.deepPurple.shade900),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.black12, Colors.black87],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          _getIconData(category.icon),
                          size: 36,
                          color: Colors.white,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          category.name,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ).animate().fade(duration: 400.ms, delay: (index * 100).ms).slideY(begin: 0.2, end: 0);
        },
      ),
    );
  }
}
