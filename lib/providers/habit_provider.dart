import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/habit.dart';
import 'dart:convert';

class HabitProvider with ChangeNotifier {
  final List<Habit> _habits = [];
  final List<Habit> _archivedHabits = [];
  final SharedPreferences _prefs;

  HabitProvider(this._prefs) {
    _loadHabits();
  }

  List<Habit> get habits => _habits;
  List<Habit> get archivedHabits => _archivedHabits;

  void addHabit(Habit habit) {
    _habits.add(habit);
    _saveHabits();
    notifyListeners();
  }

  void updateHabit(Habit updatedHabit) {
    final index = _habits.indexWhere((habit) => habit.id == updatedHabit.id);
    if (index != -1) {
      _habits[index] = updatedHabit;
      _saveHabits();
      notifyListeners();
    }
  }

  void archiveHabit(String habitId) {
    final habit = _habits.firstWhere((habit) => habit.id == habitId);
    _habits.removeWhere((habit) => habit.id == habitId);
    _archivedHabits.add(habit.copyWith(isArchived: true));
    _saveHabits();
    notifyListeners();
  }

  void restoreHabit(String habitId) {
    final habit = _archivedHabits.firstWhere((habit) => habit.id == habitId);
    _archivedHabits.removeWhere((habit) => habit.id == habitId);
    _habits.add(habit.copyWith(isArchived: false));
    _saveHabits();
    notifyListeners();
  }

  void deleteHabit(String habitId) {
    _habits.removeWhere((habit) => habit.id == habitId);
    _saveHabits();
    notifyListeners();
  }

  void markHabitComplete(String habitId, DateTime date) {
    final habit = _habits.firstWhere((habit) => habit.id == habitId);
    final updatedHabit = habit.copyWith(
      completions: {
        ...habit.completions,
        date: true,
      },
      streak: _calculateStreak(habit, date),
    );
    updateHabit(updatedHabit);
  }

  int _calculateStreak(Habit habit, DateTime date) {
    int streak = 0;
    DateTime current = date;
    
    while (habit.completions[current] == true) {
      streak++;
      current = current.subtract(const Duration(days: 1));
    }
    return streak;
  }

  void _loadHabits() {
    final habitsData = _prefs.getStringList('habits') ?? [];
    final archivedData = _prefs.getStringList('archived_habits') ?? [];

    _habits.clear();
    _archivedHabits.clear();

    for (final habitData in habitsData) {
      final habit = Habit.fromJson(jsonDecode(habitData));
      if (!habit.isArchived) {
        _habits.add(habit);
      } else {
        _archivedHabits.add(habit);
      }
    }

    for (final archivedData in archivedData) {
      final habit = Habit.fromJson(jsonDecode(archivedData));
      if (habit.isArchived) {
        _archivedHabits.add(habit);
      }
    }
    notifyListeners();
  }

  void _saveHabits() {
    final habitsData = _habits.map((habit) => jsonEncode(habit.toJson())).toList();
    final archivedData = _archivedHabits.map((habit) => jsonEncode(habit.toJson())).toList();

    _prefs.setStringList('habits', habitsData);
    _prefs.setStringList('archived_habits', archivedData);
  }
}
