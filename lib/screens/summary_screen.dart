import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/subject_provider.dart';

class SummaryScreen extends StatelessWidget {
  const SummaryScreen({super.key});

  Widget _statCard(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
  }) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: theme.colorScheme.primary.withValues(
                alpha: 0.15,
              ),
              child: Icon(icon, color: theme.colorScheme.primary),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
                ),
                Text(
                  value,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    color: theme.colorScheme.onSurface,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SubjectProvider>(
      builder: (context, subjectProvider, _) {
        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _statCard(
              context,
              icon: Icons.menu_book_outlined,
              label: 'Total Subjects',
              value: '${subjectProvider.totalSubjects}',
            ),
            const SizedBox(height: 12),
            _statCard(
              context,
              icon: Icons.percent_outlined,
              label: 'Average Mark',
              value: subjectProvider.averageMark.toStringAsFixed(2),
            ),
            const SizedBox(height: 12),
            _statCard(
              context,
              icon: Icons.emoji_events_outlined,
              label: 'Overall Grade',
              value: subjectProvider.overallGrade,
            ),
            const SizedBox(height: 12),
            _statCard(
              context,
              icon: Icons.check_circle_outline,
              label: 'Passing Subjects',
              value: '${subjectProvider.passingSubjects.length}',
            ),
          ],
        );
      },
    );
  }
}