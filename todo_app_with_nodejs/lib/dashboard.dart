import 'package:flutter/material.dart';

import 'CategoryCard.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TODO Dashboard'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Summary Cards
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildSummaryCard('Total', 10, Colors.blue),
                _buildSummaryCard('Completed', 6, Colors.green),
                _buildSummaryCard('Pending', 4, Colors.red),
              ],
            ),
            const SizedBox(height: 20),

            // Categories
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Categories',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: const [
                  CategoryCard(icon: Icons.person, title: 'Personal', color: Colors.orange),
                  CategoryCard(icon: Icons.work, title: 'Work', color: Colors.purple),
                  CategoryCard(icon: Icons.shopping_cart, title: 'Shopping', color: Colors.teal),
                  CategoryCard(icon: Icons.school, title: 'Study', color: Colors.indigo),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to Add Task screen
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildSummaryCard(String title, int count, Color color) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: color.withOpacity(0.1),
      child: Container(
        width: 100,
        height: 80,
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('$count', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: color)),
            const SizedBox(height: 5),
            Text(title, style: TextStyle(color: color)),
          ],
        ),
      ),
    );
  }
}