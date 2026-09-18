class Category {
  final String id;
  final String name;
  final String icon;
  final bool isPremium;

  Category({
    required this.id,
    required this.name,
    required this.icon,
    required this.isPremium,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      icon: json['icon'],
      isPremium: json['isPremium'],
    );
  }
}

class Prompt {
  final String id;
  final String categoryId;
  final String title;
  final String description;
  final String text;
  final String imageUrl;
  final bool isPremium;

  Prompt({
    required this.id,
    required this.categoryId,
    required this.title,
    required this.description,
    required this.text,
    required this.imageUrl,
    required this.isPremium,
  });

  factory Prompt.fromJson(Map<String, dynamic> json) {
    return Prompt(
      id: json['id'],
      categoryId: json['categoryId'],
      title: json['title'],
      description: json['description'],
      text: json['text'],
      imageUrl: json['imageUrl'] ?? '',
      isPremium: json['isPremium'],
    );
  }
}
