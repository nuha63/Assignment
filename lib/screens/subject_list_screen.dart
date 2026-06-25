import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/subject_provider.dart';

class SubjectListScreen extends StatelessWidget {
  const SubjectListScreen({super.key});

  Color _gradeColor(String grade, ColorScheme cs) {
    switch (grade) {
      case 'A':
        return cs.primary;
      case 'B':
        return cs.secondary;
      case 'C':
        return cs.tertiary ?? cs.secondary;
      default:
        return cs.error;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Consumer<SubjectProvider>(
      builder: (context, provider, _) {
        final subjects = provider.subjects;

        if (subjects.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.school_outlined,
                  size: 72,
                  color: colorScheme.onSurface.withOpacity(0.3),
                ),
                const SizedBox(height: 16),
                Text(
                  'No subjects yet',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: colorScheme.onSurface.withOpacity(0.5),
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Add a subject from the first tab',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurface.withOpacity(0.4),
                      ),
                ),
              ],
            ),
          );
        }

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
              child: Row(
                children: [
                  Text(
                    '${subjects.length} Subject${subjects.length == 1 ? '' : 's'}',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: colorScheme.onSurface,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const Spacer(),
                  Text(
                    'Swipe to delete',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurface.withOpacity(0.5),
                        ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                itemCount: subjects.length,
                itemBuilder: (context, index) {
                  final subject = subjects[index];
                  final gradeColor = _gradeColor(subject.grade, colorScheme);

                  return Dismissible(
                    key: ValueKey('${subject.name}_$index'),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      decoration: BoxDecoration(
                        color: colorScheme.error,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 20),
                      child: Icon(Icons.delete_outline,
                          color: colorScheme.onError),
                    ),
                    onDismissed: (_) {
                      provider.removeSubject(index);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${subject.name} removed'),
                          backgroundColor: colorScheme.error,
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                    child: Card(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(
                          color: gradeColor.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        leading: Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: gradeColor.withOpacity(0.15),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              subject.grade,
                              style: TextStyle(
                                color: gradeColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                        title: Text(
                          subject.name,
                          style: TextStyle(
                            color: colorScheme.onSurface,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        subtitle: Text(
                          'Mark: ${subject.mark.toStringAsFixed(1)}',
                          style: TextStyle(
                            color: colorScheme.onSurface.withOpacity(0.6),
                          ),
                        ),
                        trailing: Icon(
                          Icons.swipe_left_outlined,
                          color: colorScheme.onSurface.withOpacity(0.3),
                          size: 20,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
