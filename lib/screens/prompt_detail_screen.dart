import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../models.dart';

class PromptDetailScreen extends StatelessWidget {
  final Prompt prompt;
  const PromptDetailScreen({super.key, required this.prompt});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prompt Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Hero(
              tag: 'prompt-image-${prompt.title}',
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  prompt.imageUrl,
                  height: 250,
                  fit: BoxFit.contain,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      height: 250,
                      color: Theme.of(context).cardColor,
                      child: const Center(child: CircularProgressIndicator()),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 250,
                    color: Theme.of(context).cardColor,
                    child: const Center(child: Icon(Icons.broken_image, size: 50)),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              prompt.title,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ).animate().fade(duration: 400.ms, delay: 100.ms).slideY(begin: 0.2, end: 0),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.deepPurple.withAlpha(128), width: 1),
              ),
              child: SelectableText(
                prompt.text,
                style: const TextStyle(
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
            ).animate().fade(duration: 400.ms, delay: 200.ms).slideY(begin: 0.2, end: 0),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () async {
                await Clipboard.setData(ClipboardData(text: prompt.text));
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Prompt copied to clipboard!'),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.green,
                    ),
                  );
                }
              },
              icon: const Icon(Icons.copy),
              label: const Text('COPY TO CLIPBOARD'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
                textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ).animate().fade(duration: 400.ms, delay: 300.ms).slideY(begin: 0.2, end: 0),
          ],
        ),
      ),
    );
  }
}
