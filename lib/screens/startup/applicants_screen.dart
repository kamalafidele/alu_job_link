import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/application_cubit.dart';

class ApplicantsScreen extends StatelessWidget {
  const ApplicantsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Applicants')),
      body: BlocBuilder<ApplicationCubit, ApplicationState>(
        builder: (context, state) {
          if (state.status == ApplicationStatus.loading || state.status == ApplicationStatus.initial) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.applications.isEmpty) {
            return const Center(child: Text('No one has applied yet.'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: state.applications.length,
            itemBuilder: (context, index) {
              final app = state.applications[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 10),
                child: ListTile(
                  title: Text(app.studentName),
                  subtitle: Text('Applied for: ${app.opportunityTitle} · ${app.status}'),
                  trailing: PopupMenuButton<String>(
                    itemBuilder: (_) => const [
                      PopupMenuItem(value: 'interview', child: Text('Move to Interview')),
                      PopupMenuItem(value: 'accepted', child: Text('Accept')),
                      PopupMenuItem(value: 'rejected', child: Text('Reject')),
                    ],
                    onSelected: (value) {
                      context.read<ApplicationCubit>().updateStatus(app.id, value);
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
