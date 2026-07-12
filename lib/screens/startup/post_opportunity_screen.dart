import 'package:flutter/material.dart';

class PostOpportunityScreen extends StatefulWidget {
  const PostOpportunityScreen({super.key});

  @override
  State<PostOpportunityScreen> createState() => _PostOpportunityScreenState();
}

class _PostOpportunityScreenState extends State<PostOpportunityScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _skillsController = TextEditingController();
  String _category = 'Engineering';

  static const categories = ['Design', 'Engineering', 'Marketing', 'Research', 'Other'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Post an Opportunity')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
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
            onPressed: () {
              // TODO: build an OpportunityModel from these fields
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Opportunity posted!')),
              );
              Navigator.pop(context);
            },
            child: const Text('Post Opportunity'),
          ),
        ],
      ),
    );
  }
}
