import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class Habit {
  final String id;
  final String name;
  final Color color;
  final IconData icon;
  final DateTime reminderTime;
  final int frequency;
  final Map<DateTime, bool> completions;
  final int streak;
  final bool isArchived;

  Habit({
    String? id,
    required this.name,
    required this.color,
    required this.icon,
    required this.reminderTime,
    required this.frequency,
    Map<DateTime, bool>? completions,
    this.streak = 0,
    this.isArchived = false,
  }) : id = id ?? const Uuid().v4(),
       completions = completions ?? {};

  Habit copyWith({
    String? id,
    String? name,
    Color? color,
    IconData? icon,
    DateTime? reminderTime,
    int? frequency,
    Map<DateTime, bool>? completions,
    int? streak,
    bool? isArchived,
  }) {
    return Habit(
      id: id ?? this.id,
      name: name ?? this.name,
      color: color ?? this.color,
      icon: icon ?? this.icon,
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
      'color': color.value,
      'icon': icon.codePoint,
      'reminderTime': reminderTime.toIso8601String(),
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
      color: Color(json['color']),
      icon: IconData(json['icon'], fontFamily: 'MaterialIcons'),
      reminderTime: DateTime.parse(json['reminderTime']),
      frequency: json['frequency'],
      completions: Map.from(json['completions']).map((key, value) =>
          MapEntry(DateTime.parse(key), value)),
      streak: json['streak'],
      isArchived: json['isArchived'],
    );
  }
}
