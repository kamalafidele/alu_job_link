import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/opportunity_cubit.dart';

class StartupHomeScreen extends StatelessWidget {
  const StartupHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Postings')),
      body: BlocBuilder<OpportunityCubit, OpportunityState>(
        builder: (context, state) {
          if (state.status == OpportunityStatus.loading || state.status == OpportunityStatus.initial) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.opportunities.isEmpty) {
            return const Center(child: Text('You have no active postings yet. Tap "Post" to add one.'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: state.opportunities.length,
            itemBuilder: (context, index) {
              final opp = state.opportunities[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 10),
                child: ListTile(
                  title: Text(opp.title),
                  subtitle: Text('${opp.category} · ${opp.commitment}'),
                  trailing: const Icon(Icons.chevron_right),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
