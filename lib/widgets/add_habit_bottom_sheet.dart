import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/habit.dart';
import '../providers/habit_provider.dart';

class AddHabitBottomSheet extends StatefulWidget {
  const AddHabitBottomSheet({super.key});

  @override
  State<AddHabitBottomSheet> createState() => _AddHabitBottomSheetState();
}

class _AddHabitBottomSheetState extends State<AddHabitBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  Color _selectedColor = Colors.blue;
  IconData _selectedIcon = Icons.fitness_center;
  TimeOfDay _selectedTime = TimeOfDay.now();
  int _frequency = 1;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Add New Habit',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Habit Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a habit name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) => _ColorPicker(),
                          ).then((color) {
                            if (color != null) {
                              setState(() {
                                _selectedColor = color;
                              });
                            }
                          });
                        },
                        icon: Icon(
                          Icons.color_lens,
                          color: _selectedColor,
                        ),
                        label: const Text('Select Color'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) => _IconPicker(),
                          ).then((icon) {
                            if (icon != null) {
                              setState(() {
                                _selectedIcon = icon;
                              });
                            }
                          });
                        },
                        icon: Icon(_selectedIcon),
                        label: const Text('Select Icon'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          final time = await showTimePicker(
                            context: context,
                            initialTime: _selectedTime,
                          );
                          if (time != null) {
                            setState(() {
                              _selectedTime = time;
                            });
                          }
                        },
                        icon: const Icon(Icons.alarm),
                        label: Text(
                          _selectedTime.format(context),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: DropdownButtonFormField<int>(
                        value: _frequency,
                        decoration: const InputDecoration(
                          labelText: 'Frequency',
                          border: OutlineInputBorder(),
                        ),
                        items: const [
                          DropdownMenuItem(value: 1, child: Text('Daily')),
                          DropdownMenuItem(value: 2, child: Text('Every 2 days')),
                          DropdownMenuItem(value: 3, child: Text('Every 3 days')),
                          DropdownMenuItem(value: 7, child: Text('Weekly')),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _frequency = value ?? 1;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final habit = Habit(
                        name: _nameController.text,
                        description: "",
                        color: _selectedColor,
                        icon: _selectedIcon,
                        createdAt: DateTime.now(),
                        reminderTime: _selectedTime,
                        frequency: _frequency,
                      );
                      context.read<HabitProvider>().addHabit(habit);
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Add Habit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ColorPicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: 1,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: Colors.primaries.length,
        itemBuilder: (context, index) {
          final color = Colors.primaries[index];
          return GestureDetector(
            onTap: () => Navigator.pop(context, color),
            child: Container(
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _IconPicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final icons = [
      Icons.fitness_center,
      Icons.book,
      Icons.directions_run,
      Icons.bed,
      Icons.water_drop,
      Icons.shopping_cart,
      Icons.music_note,
      Icons.art_track,
      Icons.brush,
      Icons.code,
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: 1,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: icons.length,
        itemBuilder: (context, index) {
          final icon = icons[index];
          return GestureDetector(
            onTap: () => Navigator.pop(context, icon),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Icon(icon, size: 24),
              ),
            ),
          );
        },
      ),
    );
  }
}
