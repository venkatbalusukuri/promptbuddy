import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../data_service.dart';
import '../models.dart';
import 'prompt_detail_screen.dart';

class PromptListScreen extends StatefulWidget {
  final Category category;
  const PromptListScreen({super.key, required this.category});

  @override
  State<PromptListScreen> createState() => _PromptListScreenState();
}

class _PromptListScreenState extends State<PromptListScreen> {
  final dataService = DataService();
  late List<Prompt> prompts;

  @override
  void initState() {
    super.initState();
    prompts = dataService.getPromptsForCategory(widget.category.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.name),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: prompts.length,
        itemBuilder: (context, index) {
          final prompt = prompts[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            child: ListTile(
              leading: Hero(
                tag: 'prompt-image-${prompt.title}',
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    prompt.imageUrl,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const Icon(Icons.image, size: 50),
                  ),
                ),
              ),
              title: Text(
                prompt.title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                prompt.text,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PromptDetailScreen(prompt: prompt),
                  ),
                );
              },
            ),
          ).animate().fade(duration: 300.ms, delay: (index * 50).ms).slideX(begin: 0.1, end: 0);
        },
      ),
    );
  }
}
