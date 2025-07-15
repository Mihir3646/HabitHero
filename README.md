# Habit Hero

## Overview

**Habit Hero** is a minimal, privacy-first habit tracker app that stores all core data locally on the device. Users can optionally back up and restore their data via cloud storage services like Google Drive or iCloud.

## Features

### Onboarding & Home
- Welcome screens with a 3-step introduction to the app, privacy, and quick start.
- Flow to create a new habit.

### Habit Dashboard (Main Screen)
- Display a grid or list of habits, each as a colored tile with an icon, name, and color.
- Streak counter and badge.
- Heat-map/calendar visualization for each habit.
- "Add Habit" floating button.

### Habit Details & Editing
- Edit/add habit sheet with fields for name, color, icon, reminder time, and frequency.
- History/calendar view to edit backdated completions and view streaks.
- Mark habit as complete via tap, swipe, or button.

### Reminders
- Set one reminder per habit.
- List upcoming reminders via settings or habit detail.

### Analytics
- Simple statistics: total completions, longest streak, current streak, success rate.
- Visual display using charts, cards, and progress bars.

### Habit Management
- Archive and restore habits.
- Delete habit with undo option for accidental actions.

### App Settings
- Theme options: Light, Dark, High-contrast.
- Data export/import via CSV/JSON.
- Backup/restore via Google Drive/iCloud.
- App info and help section.

### Accessibility
- Support for large fonts, high-contrast, and VoiceOver/labels.

## Design Prompt for Stitch/Figma

### App Overview
Design a minimal, modern, and highly intuitive habit tracking app called "Habit Hero". All core functionality works offline and stores data locally, with optional cloud backup/restore (no account required).

### Core Principles
- Focus on clarity, minimalism, and user motivation.
- Visualize progress with grids, streaks, and heat-maps (like GitHub’s contribution chart).
- All features accessible in 2 taps or less.
- Accessibility (large text, high contrast) is a priority.

### Screens to Design
1. **Onboarding**: 3–4 slides introducing app, privacy, and key features.
2. **Dashboard**: Colorful grid/list of habits, each tile shows name, icon, current streak, and progress. “Add Habit” button is always visible.
3. **Add/Edit Habit**: Bottom sheet or modal with fields for name, color, icon, reminder, and frequency.
4. **Habit Details/Calendar**: Heat-map/calendar view for each habit. Tap on a day to mark/unmark completion.
5. **Analytics**: Simple cards or charts for success rate, total completions, current and longest streak.
6. **Archive/Restore**: List of archived habits with option to restore.
7. **Settings**: Theme toggle, backup/restore, import/export data, and help/about.
8. **Backup/Restore Modal**: UI for cloud backup (Google Drive/iCloud), import/export local files.
9. **Accessibility Mode**: Example screen showing high-contrast, large fonts, clear navigation.

### Style Reference
- Material 3 or Cupertino, but visually clean and modern.
- Inspiration: HabitKit, Productive, Streaks, and Apple Health app.
- Use motivating colors, clear fonts, and friendly icons.

### Note
Prioritize ease of use for first-time users. No sign-up/login screens. All privacy messaging should be prominent in onboarding and settings.
