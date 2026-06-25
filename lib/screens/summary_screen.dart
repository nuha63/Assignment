import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/subject_provider.dart';

class SummaryScreen extends StatelessWidget {
  const SummaryScreen({super.key});

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
        final total = provider.totalSubjects;
        final avg = provider.averageMark;
        final overall = provider.overallGrade;
        final passing = provider.passingSubjects;
        final gradeColor = _gradeColor(overall, colorScheme);

        return SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 8),
              Text(
                'Result Summary',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: colorScheme.onSurface,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 24),

              // Overall grade card
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide(color: gradeColor.withOpacity(0.4), width: 2),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      Text(
                        'Overall Grade',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: colorScheme.onSurface.withOpacity(0.7),
                            ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: gradeColor.withOpacity(0.15),
                          shape: BoxShape.circle,
                          border: Border.all(color: gradeColor, width: 3),
                        ),
                        child: Center(
                          child: Text(
                            total == 0 ? '—' : overall,
                            style: TextStyle(
                              color: gradeColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 36,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        total == 0
                            ? 'Add subjects to see your grade'
                            : 'Average: ${avg.toStringAsFixed(1)}%',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: colorScheme.onSurface.withOpacity(0.6),
                            ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Stats row
              Row(
                children: [
                  Expanded(
                    child: _StatCard(
                      label: 'Total Subjects',
                      value: '$total',
                      icon: Icons.library_books_outlined,
                      color: colorScheme.primary,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _StatCard(
                      label: 'Passing',
                      value: '${passing.length}',
                      icon: Icons.check_circle_outline,
                      color: colorScheme.secondary,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              if (total > 0) ...[
                Text(
                  'Passing Subjects',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: colorScheme.onSurface,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 8),
                if (passing.isEmpty)
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        'No passing subjects yet',
                        style: TextStyle(
                          color: colorScheme.onSurface.withOpacity(0.5),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                else
                  ...passing.map(
                    (s) => Card(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor:
                              _gradeColor(s.grade, colorScheme).withOpacity(0.15),
                          child: Text(
                            s.grade,
                            style: TextStyle(
                              color: _gradeColor(s.grade, colorScheme),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        title: Text(
                          s.name,
                          style: TextStyle(color: colorScheme.onSurface),
                        ),
                        trailing: Text(
                          '${s.mark.toStringAsFixed(1)}',
                          style: TextStyle(
                            color: colorScheme.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ],
          ),
        );
      },
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 8),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurface.withOpacity(0.6),
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
