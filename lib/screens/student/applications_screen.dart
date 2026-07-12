import 'package:flutter/material.dart';
import '../../mock_data.dart';

class ApplicationsScreen extends StatelessWidget {
  const ApplicationsScreen({super.key});

  Color _statusColor(String status) {
    switch (status) {
      case 'accepted':
        return Colors.green;
      case 'interview':
        return Colors.orange;
      case 'rejected':
        return Colors.red;
      default:
        return Colors.blueGrey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Applications')),
      body: mockApplications.isEmpty
          ? const Center(child: Text("You haven't applied to anything yet."))
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: mockApplications.length,
        itemBuilder: (context, index) {
          final app = mockApplications[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 10),
            child: ListTile(
              title: Text(app.opportunityTitle),
              subtitle: Text(app.startupName),
              trailing: Chip(
                label: Text(
                  app.status,
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
                backgroundColor: _statusColor(app.status),
              ),
            ),
          );
        },
      ),
    );
  }
}
