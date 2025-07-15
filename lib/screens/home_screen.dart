import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/habit_provider.dart';
import '../widgets/habit_tile.dart';
import '../widgets/add_habit_bottom_sheet.dart';
import '../models/habit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final habits = context.watch<HabitProvider>().habits;

    Widget buildDots() {
      return SizedBox(
        height: 100,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 7,
          itemBuilder: (context, weekIndex) {
            return Column(
              children: List.generate(7, (dayIndex) {
                return Container(
                  margin: const EdgeInsets.all(2.0),
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (weekIndex + dayIndex) % 2 == 0
                        ? Colors.blue
                        : Colors.grey,
                  ),
                );
              }),
            );
          },
        ),
      );
    }

    Widget buildLargeCard(Habit habit) {
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
                    habit.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(
                    habit.isCompletedToday
                        ? Icons.check_circle
                        : Icons.add_circle,
                    color:
                        habit.isCompletedToday ? Colors.pink : Colors.blue,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              buildDots(),
            ],
          ),
        ),
      );
    }

    Widget buildSmallCard(Habit habit) {
      return Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(habit.icon, color: habit.color),
            const SizedBox(height: 8),
            Text(habit.name),
          ],
        ),
      );
    }

    final pages = [
      ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: habits.length,
        itemBuilder: (context, index) => buildLargeCard(habits[index]),
      ),
      ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: habits.length,
        itemBuilder: (context, index) => HabitTile(habit: habits[index]),
      ),
      GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.3,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: habits.length,
        itemBuilder: (context, index) => buildSmallCard(habits[index]),
      ),
    ];

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
        actions: [
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
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: pages,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.symmetric(horizontal: 24),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(
                Icons.grid_view,
                color: _currentIndex == 0
                    ? Theme.of(context).colorScheme.primary
                    : Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  _currentIndex = 0;
                });
                _pageController.jumpToPage(0);
              },
            ),
            IconButton(
              icon: Icon(
                Icons.checklist,
                color: _currentIndex == 1
                    ? Theme.of(context).colorScheme.primary
                    : Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  _currentIndex = 1;
                });
                _pageController.jumpToPage(1);
              },
            ),
            IconButton(
              icon: Icon(
                Icons.view_list,
                color: _currentIndex == 2
                    ? Theme.of(context).colorScheme.primary
                    : Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  _currentIndex = 2;
                });
                _pageController.jumpToPage(2);
              },
            ),
          ],
        ),
      ),
    );
  }

}
