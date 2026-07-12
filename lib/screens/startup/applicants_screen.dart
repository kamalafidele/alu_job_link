import 'package:flutter/material.dart';
import '../../mock_data.dart';

class ApplicantsScreen extends StatelessWidget {
  const ApplicantsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Applicants')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: mockApplications.length,
        itemBuilder: (context, index) {
          final app = mockApplications[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 10),
            child: ListTile(
              title: Text('Applicant for: ${app.opportunityTitle}'),
              subtitle: Text('Status: ${app.status}'),
              trailing: PopupMenuButton<String>(
                itemBuilder: (_) => const [
                  PopupMenuItem(value: 'interview', child: Text('Move to Interview')),
                  PopupMenuItem(value: 'accepted', child: Text('Accept')),
                  PopupMenuItem(value: 'rejected', child: Text('Reject')),
                ],
                onSelected: (value) {
                  // TODO: update the application's status field in Firestore.
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Marked as $value')),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
