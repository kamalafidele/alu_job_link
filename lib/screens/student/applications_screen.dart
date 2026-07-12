import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/application_cubit.dart';

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
      body: BlocBuilder<ApplicationCubit, ApplicationState>(
        builder: (context, state) {
          if (state.status == ApplicationStatus.loading || state.status == ApplicationStatus.initial) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.applications.isEmpty) {
            return const Center(child: Text("You haven't applied to anything yet."));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: state.applications.length,
            itemBuilder: (context, index) {
              final app = state.applications[index];
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
          );
        },
      ),
    );
  }
}
