import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/auth_cubit.dart';
import '../../cubit/opportunity_cubit.dart';
import '../../widgets/opportunity_card.dart';
import 'opportunity_details_screen.dart';

class StudentHomeScreen extends StatelessWidget {
  const StudentHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final name = context.watch<AuthCubit>().state.name ?? 'there';

    return Scaffold(
      appBar: AppBar(
        title: Text('Hello, $name 👋'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications_none)),
        ],
      ),
      body: BlocBuilder<OpportunityCubit, OpportunityState>(
        builder: (context, state) {
          if (state.status == OpportunityStatus.loading || state.status == OpportunityStatus.initial) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.status == OpportunityStatus.error) {
            return Center(child: Text('Something went wrong: ${state.errorMessage}'));
          }
          if (state.opportunities.isEmpty) {
            return const Center(child: Text('No opportunities posted yet - check back soon!'));
          }

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: 'Search opportunities...',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              const Text('Recent opportunities',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 12),
              ...state.opportunities.map(
                    (opp) => OpportunityCard(
                  opportunity: opp,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => OpportunityDetailsScreen(opportunity: opp),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
