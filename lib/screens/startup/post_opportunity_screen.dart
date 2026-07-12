import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/auth_cubit.dart';
import '../../cubit/opportunity_cubit.dart';
import '../../models/opportunity_model.dart';

class PostOpportunityScreen extends StatefulWidget {
  const PostOpportunityScreen({super.key});

  @override
  State<PostOpportunityScreen> createState() => _PostOpportunityScreenState();
}

class _PostOpportunityScreenState extends State<PostOpportunityScreen> {
  final _titleController = TextEditingController();
  final _commitmentController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _skillsController = TextEditingController();
  String _category = 'Engineering';
  bool _submitting = false;

  static const categories = ['Design', 'Engineering', 'Marketing', 'Research', 'Other'];

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthCubit>().state;

    return Scaffold(
      appBar: AppBar(title: const Text('Post an Opportunity')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          if (!auth.verified)
            Container(
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.orange.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'Your startup account is still pending verification. You can '
                    'draft a posting below, but it will only go live once an admin '
                    'verifies your account.',
                style: TextStyle(fontSize: 13),
              ),
            ),
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(labelText: 'Title (e.g. Flutter Developer)'),
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            initialValue: _category,
            decoration: const InputDecoration(labelText: 'Category'),
            items: categories
                .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                .toList(),
            onChanged: (val) => setState(() => _category = val ?? _category),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _commitmentController,
            decoration: const InputDecoration(
              labelText: 'Time commitment',
              hintText: 'e.g. Part-time (8-10 hrs/week)',
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _descriptionController,
            maxLines: 4,
            decoration: const InputDecoration(
              labelText: 'Description',
              alignLabelWithHint: true,
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _skillsController,
            decoration: const InputDecoration(
              labelText: 'Skills needed (comma separated)',
              hintText: 'Flutter, Dart, Firebase',
            ),
          ),
          const SizedBox(height: 24),
          FilledButton(
            onPressed: _submitting
                ? null
                : () async {
              if (_titleController.text.trim().isEmpty) return;
              setState(() => _submitting = true);

              final opportunity = OpportunityModel(
                id: '', // Firestore assigns this when we .add() it
                title: _titleController.text.trim(),
                startupId: auth.uid!,
                startupName: auth.name ?? 'Startup',
                description: _descriptionController.text.trim(),
                category: _category,
                commitment: _commitmentController.text.trim(),
                skills: _skillsController.text
                    .split(',')
                    .map((s) => s.trim())
                    .where((s) => s.isNotEmpty)
                    .toList(),
                postedAt: DateTime.now(),
              );

              await context.read<OpportunityCubit>().postOpportunity(opportunity);

              if (context.mounted) {
                _titleController.clear();
                _commitmentController.clear();
                _descriptionController.clear();
                _skillsController.clear();
                setState(() => _submitting = false);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Opportunity posted!')),
                );
              }
            },
            child: _submitting
                ? const SizedBox(
                height: 18, width: 18, child: CircularProgressIndicator(strokeWidth: 2))
                : const Text('Post Opportunity'),
          ),
        ],
      ),
    );
  }
}
