import 'package:flutter/material.dart';
import 'package:todoapp/theme.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({Key? key, this.note, this.title}) : super(key: key);
  final String? note;
  final String? title;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title ?? 'Get Started',
              style: TodoTheme.lightTextTheme.headline2,
              maxLines: 1,
            ),
            const SizedBox(height: 8),
            Text(
              title ??
                  'Hello User! Welcome to WHAT_TODO app, this is a default task that you can edit or delete to start using the app.',
              style: TodoTheme.lightTextTheme.bodySmall,
              maxLines: 3,
            ),
            const SizedBox(height: 8),
            Chip(
              label: const Text('Important'),
              backgroundColor: TodoTheme.normalChipColor,
            )
          ],
        ),
      ),
    );
  }
}
