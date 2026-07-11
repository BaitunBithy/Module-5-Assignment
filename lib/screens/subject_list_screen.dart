import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/subject_provider.dart';

class SubjectListScreen extends StatelessWidget {
  const SubjectListScreen({super.key});

  Color _gradeColor(BuildContext context, String grade) {
    final scheme = Theme.of(context).colorScheme;
    switch (grade) {
      case 'A':
        return scheme.primary;
      case 'B':
        return scheme.secondary;
      case 'C':
        return scheme.tertiary;
      default:
        return scheme.error;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Consumer<SubjectProvider>(
      builder: (context, subjectProvider, _) {
        final subjects = subjectProvider.subjects;

        if (subjects.isEmpty) {
          return Center(
            child: Text(
              'No subjects added yet.\nGo to "Add" tab to create one.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: subjects.length,
          itemBuilder: (context, index) {
            final subject = subjects[index];

            return Dismissible(
              key: ValueKey(subject.id),
              direction: DismissDirection.endToStart,
              background: Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                margin: const EdgeInsets.symmetric(vertical: 6),
                decoration: BoxDecoration(
                  color: theme.colorScheme.error,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.delete_outline,
                  color: theme.colorScheme.onError,
                ),
              ),
              onDismissed: (_) {
                final name = subject.name;
                context.read<SubjectProvider>().removeSubjectById(subject.id);
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text('$name removed')));
              },
              child: Card(
                margin: const EdgeInsets.symmetric(vertical: 6),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: _gradeColor(context, subject.grade),
                    child: Text(
                      subject.grade,
                      style: TextStyle(
                        color: theme.colorScheme.onPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  title: Text(subject.name),
                  subtitle: Text('Mark: ${subject.mark.toStringAsFixed(1)}'),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
