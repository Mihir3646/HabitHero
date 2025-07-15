import 'package:flutter/material.dart';

const cornflowerBlue = Color(0xFF6495ED);

class AddHabitScreen extends StatelessWidget {
  const AddHabitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'New Habit',
          style: TextStyle(
            color: Color(0xFF111518),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Habit name',
                filled: true,
                fillColor: const Color(0xFFF0F3F4),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Color(0xFF1993E5),
                    width: 2,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Color',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF111518),
              ),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10,
              children: List.generate(6, (index) {
                final colors = [
                  Colors.red,
                  Colors.yellow,
                  Colors.lime,
                  Colors.teal,
                  cornflowerBlue,
                  Colors.blueAccent,
                  Colors.purple[200],
                ];
                return ChoiceChip(
                  label: Container(),
                  selected: index == 0,
                  onSelected: (selected) {},
                  backgroundColor: colors[index],
                  shape: const CircleBorder(),
                );
              }),
            ),
            const SizedBox(height: 20),
            const Text(
              'Icon',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF111518),
              ),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10,
              children: List.generate(8, (index) {
                final icons = [
                  Icons.wb_sunny,
                  Icons.nightlight_round,
                  Icons.local_cafe,
                  Icons.fitness_center,
                  Icons.book,
                  Icons.brush,
                  Icons.music_note,
                  Icons.spa,
                ];
                return ChoiceChip(
                  label: Icon(icons[index]),
                  selected: index == 0,
                  onSelected: (selected) {},
                );
              }),
            ),
            const SizedBox(height: 20),
            const Text(
              'Reminder',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF111518),
              ),
            ),
            Switch(
              value: false,
              onChanged: (value) {},
            ),
            const SizedBox(height: 20),
            const Text(
              'Frequency',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF111518),
              ),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10,
              children: const [
                ChoiceChip(
                  label: Text('Daily'),
                  selected: false,
                ),
                ChoiceChip(
                  label: Text('Weekly'),
                  selected: true,
                ),
                ChoiceChip(
                  label: Text('Monthly'),
                  selected: false,
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF0F3F4),
                    ),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        color: Color(0xFF111518),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // TODO: Implement save action
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1993E5),
                    ),
                    child: const Text(
                      'Save',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
