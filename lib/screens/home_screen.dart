import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text.rich(
          TextSpan(
            children: [
              TextSpan(text: 'Habit', style: TextStyle(color: Colors.black)),
              TextSpan(text: 'Kit', style: TextStyle(color: Colors.purple)),
            ],
          ),
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.settings),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ChoiceChip(
                  label: const Text('Fitness'),
                  selected: true,
                  onSelected: (selected) {},
                ),
                const SizedBox(width: 8),
                ChoiceChip(
                  label: const Text('Health'),
                  selected: false,
                  onSelected: (selected) {},
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  _buildHabitCard('Study', 'Jul 2025', true),
                  const SizedBox(height: 16),
                  _buildHabitCard('Exercise', 'Jul 2025', false),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.checklist),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.view_list),
            label: '',
          ),
        ],
      ),
    );
  }

  Widget _buildHabitCard(String title, String date, bool isCompleted) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(
                  isCompleted ? Icons.check_circle : Icons.add_circle,
                  color: isCompleted ? Colors.pink : Colors.blue,
                ),
              ],
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 7, // 7 days of the week
                itemBuilder: (context, weekIndex) {
                  return Column(
                    children: List.generate(7, (dayIndex) {
                      return Container(
                        margin: const EdgeInsets.all(2.0),
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: (weekIndex + dayIndex) % 2 == 0 ? Colors.blue : Colors.grey,
                        ),
                      );
                    }),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
