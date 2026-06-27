import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/subject.dart';
import '../providers/subject_provider.dart';

class AddSubjectScreen extends StatefulWidget {
  const AddSubjectScreen({super.key});

  @override
  State<AddSubjectScreen> createState() => _AddSubjectScreenState();
}

class _AddSubjectScreenState extends State<AddSubjectScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _markController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _markController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final subject = Subject(
        name: _nameController.text.trim(),
        mark: double.parse(_markController.text.trim()),
      );
      context.read<SubjectProvider>().addSubject(subject);
      _nameController.clear();
      _markController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Subject added! Grade: ${subject.grade}',
            style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
          ),
          backgroundColor: Theme.of(context).colorScheme.primary,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 12),
            Text(
              'Add a New Subject',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: colorScheme.onSurface,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 24),
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Subject Name',
                hintText: 'e.g. Mathematics',
                prefixIcon: Icon(Icons.book_outlined),
              ),
              textCapitalization: TextCapitalization.words,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Subject name cannot be empty';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _markController,
              decoration: const InputDecoration(
                labelText: 'Mark (0 – 100)',
                hintText: 'e.g. 75',
                prefixIcon: Icon(Icons.grade_outlined),
              ),
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Mark cannot be empty';
                }
                final mark = double.tryParse(value.trim());
                if (mark == null) return 'Enter a valid number';
                if (mark < 0 || mark > 100) {
                  return 'Mark must be between 0 and 100';
                }
                return null;
              },
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: _submit,
              icon: const Icon(Icons.add),
              label: const Text('Add Subject'),
            ),
            const SizedBox(height: 24),
            const _GradeReferenceCard(),
          ],
        ),
      ),
    );
  }
}

class _GradeReferenceCard extends StatelessWidget {
  const _GradeReferenceCard();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final grades = [
      ('A', '≥ 80', colorScheme.primary),
      ('B', '≥ 65', colorScheme.secondary),
      ('C', '≥ 50', colorScheme.tertiary),
      ('F', '< 50', colorScheme.error),
    ];

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Grade Reference',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: colorScheme.onSurface,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: grades
                  .map(
                    (g) => Column(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: g.$3.withOpacity(0.15),
                            shape: BoxShape.circle,
                            border: Border.all(color: g.$3, width: 2),
                          ),
                          child: Center(
                            child: Text(
                              g.$1,
                              style: TextStyle(
                                color: g.$3,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          g.$2,
                          style: TextStyle(
                            color: colorScheme.onSurface.withOpacity(0.7),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
