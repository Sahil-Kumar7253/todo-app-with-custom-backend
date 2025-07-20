import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;

  const CategoryCard({
    super.key,
    required this.icon,
    required this.title,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: color.withOpacity(0.1),
        ),
        child: InkWell(
          onTap: () {
            // Navigate to category-specific task list
          },
          borderRadius: BorderRadius.circular(12),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, size: 30, color: color),
                const SizedBox(height: 8),
                Text(title, style: TextStyle(fontSize: 16, color: color)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}