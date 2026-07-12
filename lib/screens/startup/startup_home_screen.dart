import 'package:flutter/material.dart';
import '../../mock_data.dart';

class StartupHomeScreen extends StatelessWidget {
  const StartupHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final myPostings = mockOpportunities;

    return Scaffold(
      appBar: AppBar(title: const Text('My Postings')),
      body: myPostings.isEmpty
          ? const Center(child: Text('You have no active postings yet.'))
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: myPostings.length,
        itemBuilder: (context, index) {
          final opp = myPostings[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 10),
            child: ListTile(
              title: Text(opp.title),
              subtitle: Text('${opp.category} · ${opp.commitment}'),
              trailing: const Icon(Icons.chevron_right),
            ),
          );
        },
      ),
    );
  }
}
