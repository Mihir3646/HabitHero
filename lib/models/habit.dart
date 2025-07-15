import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class Habit {
  final String id;
  final String name;
  final String description;
  final Color color;
  final IconData icon;
  final DateTime createdAt;
  final List<DateTime> completedDates;
  final TimeOfDay? reminderTime;
  final int frequency;
  final Map<DateTime, bool> completions;
  final int streak;
  final bool isArchived;

  Habit({
    String? id,
    required this.name,
    required this.description,
    required this.color,
    required this.icon,
    required this.createdAt,
    this.completedDates = const [],
    this.reminderTime,
    this.frequency = 1,
    Map<DateTime, bool>? completions,
    this.streak = 0,
    this.isArchived = false,
  }) : id = id ?? const Uuid().v4(),
       completions = completions ?? {};

  bool get isCompletedToday {
    final today = DateTime.now().toLocal();
    return completedDates.any((date) {
      return date.year == today.year &&
          date.month == today.month &&
          date.day == today.day;
    });
  }

  double get completionPercentage {
    if (completedDates.isEmpty) return 0.0;
    final daysSinceCreation = DateTime.now().difference(createdAt).inDays;
    return (completedDates.length / daysSinceCreation) * 100;
  }

  Habit copyWith({
    String? id,
    String? name,
    String? description,
    Color? color,
    IconData? icon,
    List<DateTime>? completedDates,
    TimeOfDay? reminderTime,
    int? frequency,
    Map<DateTime, bool>? completions,
    int? streak,
    bool? isArchived,
  }) {
    return Habit(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      color: color ?? this.color,
      icon: icon ?? this.icon,
      createdAt: createdAt,
      completedDates: completedDates ?? this.completedDates,
      reminderTime: reminderTime ?? this.reminderTime,
      frequency: frequency ?? this.frequency,
      completions: completions ?? this.completions,
      streak: streak ?? this.streak,
      isArchived: isArchived ?? this.isArchived,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'color': color.value,
      'icon': icon.codePoint,
      'createdAt': createdAt.toIso8601String(),
      'completedDates': completedDates.map((date) => date.toIso8601String()).toList(),
      'reminderTime': reminderTime == null ? null : {'hour': reminderTime?.hour, 'minute': reminderTime?.minute},
      'frequency': frequency,
      'completions': completions.map((key, value) => MapEntry(
        key.toIso8601String(),
        value,
      )),
      'streak': streak,
      'isArchived': isArchived,
    };
  }

  static Habit fromJson(Map<String, dynamic> json) {
    return Habit(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      color: Color(json['color']),
      icon: IconData(json['icon'], fontFamily: 'MaterialIcons'),
      createdAt: DateTime.parse(json['createdAt']),
      completedDates: (json['completedDates'] as List).map((date) => DateTime.parse(date)).toList(),
      reminderTime: json['reminderTime'] != null ? TimeOfDay(hour: json['reminderTime']['hour'], minute: json['reminderTime']['minute']) : null,
      frequency: json['frequency'],
      completions: Map.from(json['completions']).map((key, value) =>
          MapEntry(DateTime.parse(key), value)),
      streak: json['streak'],
      isArchived: json['isArchived'],
    );
  }
}
