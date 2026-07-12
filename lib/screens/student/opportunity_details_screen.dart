import 'package:flutter/material.dart';
import '../../models/opportunity_model.dart';

class OpportunityDetailsScreen extends StatelessWidget {
  final OpportunityModel opportunity;

  const OpportunityDetailsScreen({super.key, required this.opportunity});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Opportunity Details')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(opportunity.title,
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            Text(opportunity.startupName,
                style: const TextStyle(color: Colors.grey, fontSize: 15)),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              children: opportunity.skills
                  .map((s) => Chip(label: Text(s)))
                  .toList(),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Icon(Icons.schedule, size: 18, color: Colors.grey),
                const SizedBox(width: 6),
                Text(opportunity.commitment),
              ],
            ),
            const SizedBox(height: 24),
            const Text('About', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(opportunity.description),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () {
                  // TODO: create an ApplicationModel document in Firestore.
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Application submitted!')),
                  );
                },
                child: const Text('Apply Now'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
