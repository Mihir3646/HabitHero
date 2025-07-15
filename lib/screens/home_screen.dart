import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/habit_provider.dart';
import '../widgets/habit_tile.dart';
import '../widgets/add_habit_bottom_sheet.dart';
import '../models/habit.dart';
import 'settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final habits = context.watch<HabitProvider>().habits;

    // Dots grid builder for each habit, horizontally scrollable, 1 row per day, customizable colors
    Widget buildDotsGrid({required List<bool> completions, Color? activeColor, Color? inactiveColor}) {
      return SizedBox(
        height: 32,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: completions.length,
          itemBuilder: (context, i) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: completions[i] ? (activeColor ?? Colors.purple[200]) : (inactiveColor ?? Colors.grey[200]),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: completions[i] ? (activeColor ?? Colors.purple) : Colors.grey[300]!,
                  width: completions[i] ? 2 : 1,
                ),
              ),
              child: completions[i]
                  ? const Icon(Icons.check, size: 14, color: Colors.white)
                  : null,
            );
          },
        ),
      );
    }

    Widget buildLargeCard(Habit habit) {
      // Example: last 5 days completion
      final completions = List.generate(5, (i) => habit.isCompletedToday && i == 4);
      return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 0,
        color: habit.isCompletedToday ? Colors.purple[50] : Colors.pink[50],
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.monitor_heart, color: Colors.grey[700]),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          habit.name,
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          habit.description ?? '',
                          style: const TextStyle(fontSize: 14, color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.purple[200]!, width: 2),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: Icon(
                        habit.isCompletedToday ? Icons.check : Icons.add,
                        color: habit.isCompletedToday ? Colors.purple : Colors.purple[200],
                      ),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              buildDotsGrid(
                completions: completions,
                activeColor: habit.isCompletedToday ? Colors.purple : Colors.pink,
                inactiveColor: Colors.grey[200],
              ),
            ],
          ),
        ),
      );
    }

    Widget buildListTile(Habit habit) {
      return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        elevation: 0,
        margin: const EdgeInsets.symmetric(vertical: 8),
        color: habit.isCompletedToday ? Colors.purple[50] : Colors.pink[50],
        child: ListTile(
          leading: Icon(Icons.monitor_heart, color: Colors.grey[700]),
          title: Text(
            habit.name,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
          ),
          subtitle: Text(
            habit.description ?? '',
            style: const TextStyle(color: Colors.black54),
          ),
          trailing: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.purple[200]!, width: 2),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: Icon(
                habit.isCompletedToday ? Icons.check : Icons.add,
                color: habit.isCompletedToday ? Colors.purple : Colors.purple[200],
              ),
              onPressed: () {},
            ),
          ),
        ),
      );
    }

    // Small grid for the 3rd (small card grid) view
    Widget buildSmallGrid({int rows = 5, int cols = 5, Color? activeColor, Color? inactiveColor, required List<bool> completions}) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          children: List.generate(rows, (row) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(cols, (col) {
                int idx = row * cols + col;
                return Container(
                  margin: const EdgeInsets.all(2),
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: (idx < completions.length && completions[idx]) ? (activeColor ?? Colors.purple[200]) : (inactiveColor ?? Colors.grey[200]),
                    borderRadius: BorderRadius.circular(4),
                  ),
                );
              }),
            );
          }),
        ),
      );
    }

    Widget buildSmallCard(Habit habit) {
      // Example: 5x5 grid, 25 days, random completion
      final completions = List.generate(25, (i) => habit.isCompletedToday && i % 7 == 0);
      return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 0,
        color: habit.isCompletedToday ? Colors.purple[50] : Colors.pink[50],
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: habit.isCompletedToday ? Colors.purple[200]! : Colors.pink[200]!, width: 2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      habit.isCompletedToday ? Icons.check : Icons.add,
                      color: habit.isCompletedToday ? Colors.purple : Colors.purple[200],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        habit.name,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      Text(
                        'Jul 2025',
                        style: const TextStyle(fontSize: 12, color: Colors.black54),
                      ),
                    ],
                  ),
                ],
              ),
              buildSmallGrid(
                completions: completions,
                activeColor: habit.isCompletedToday ? Colors.purple : Colors.pink,
                inactiveColor: Colors.grey[200],
              ),
            ],
          ),
        ),
      );
    }

    Widget body;
    switch (_currentIndex) {
      case 0:
        body = ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: habits.length,
          itemBuilder: (context, index) => buildLargeCard(habits[index]),
        );
        break;
      case 1:
        body = ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: habits.length,
          itemBuilder: (context, index) => buildListTile(habits[index]),
        );
        break;
      default:
        body = GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.3,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: habits.length,
          itemBuilder: (context, index) => buildSmallCard(habits[index]),
        );
    }

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
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SettingsScreen()),
            );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.show_chart), // Analytics icon
            onPressed: () {
              // TODO: Navigate to analytics screen or show analytics dialog
            },
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (_) => const AddHabitBottomSheet(),
              );
            },
          ),
        ],
      ),
      body: body,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
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
}
