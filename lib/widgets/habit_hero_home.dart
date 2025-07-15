import 'package:flutter/material.dart';

class HabitHeroHomePage extends StatelessWidget {
  const HabitHeroHomePage({super.key});

  // Custom colors (from your CSS variables)
  static const background = Color(0xFF121212);
  static const surface = Color(0xFF1e1e1e);
  static const primary = Color(0xFF0c92f2);
  static const secondary = Color(0xFF27ae60);
  static const accent = Color(0xFFf2994a);
  static const textPrimary = Colors.white;
  static const textSecondary = Color(0xFFA0A0A0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Column(
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(width: 24), // Placeholder for left
                      const Text(
                        'Habit Hero',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          color: textPrimary,
                          fontFamily: 'Manrope',
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.settings, color: textPrimary),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                // Heatmap grid
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SizedBox(
                    height: 120,
                    child: GridView.count(
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 20,
                      crossAxisSpacing: 4,
                      mainAxisSpacing: 4,
                      children: _buildHeatmapCells(),
                    ),
                  ),
                ),
                // Habit cards
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Column(
                      children: [
                        _HabitCard(
                          emoji: '🏋️',
                          title: 'Go to Gym',
                          subtitle: 'Completed today',
                          streak: 12,
                          color: primary,
                        ),
                        const SizedBox(height: 12),
                        _HabitCard(
                          emoji: '📖',
                          title: 'Read 10 Pages',
                          subtitle: 'Streak: 5 days',
                          streak: 5,
                          color: secondary,
                        ),
                        const SizedBox(height: 12),
                        _HabitCard(
                          emoji: '🧘',
                          title: 'Meditate',
                          subtitle: 'Streak: 21 days',
                          streak: 21,
                          color: accent,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 12, right: 8),
        child: FloatingActionButton(
          backgroundColor: primary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          elevation: 8,
          onPressed: () {},
          child: const Icon(Icons.add, size: 32, color: Colors.white),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }

  List<Widget> _buildHeatmapCells() {
    // Example: 100 cells with various levels
    const levels = [0, 1, 2, 3, 4];
    final cells = <Widget>[];
    final colors = [
      surface, // default
      Color(0xFF1a3a53), // level-1
      Color(0xFF185380), // level-2
      Color(0xFF106ca8), // level-3
      primary, // level-4
    ];
    final pattern = [0, 0, 1, 0, 2, 1, 0, 0, 0, 3, 0, 0, 4, 2, 0, 1, 0, 0, 0, 1];
    for (int i = 0; i < 100; i++) {
      int level = pattern[i % pattern.length];
      cells.add(Container(
        decoration: BoxDecoration(
          color: colors[level],
          borderRadius: BorderRadius.circular(6),
        ),
      ));
    }
    return cells;
  }
}

class _HabitCard extends StatelessWidget {
  final String emoji;
  final String title;
  final String subtitle;
  final int streak;
  final Color color;

  const _HabitCard({
    required this.emoji,
    required this.title,
    required this.subtitle,
    required this.streak,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: HabitHeroHomePage.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(999),
                ),
                padding: const EdgeInsets.all(12),
                child: Text(
                  emoji,
                  style: const TextStyle(fontSize: 24),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: HabitHeroHomePage.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 14,
                      color: HabitHeroHomePage.textSecondary,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              const Text('🔥', style: TextStyle(fontSize: 20, color: accent)),
              const SizedBox(width: 4),
              Text(
                '$streak',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: HabitHeroHomePage.textPrimary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
