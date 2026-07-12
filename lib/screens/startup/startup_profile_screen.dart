import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/auth_cubit.dart';

class StartupProfileScreen extends StatelessWidget {
  const StartupProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final name = context.watch<AuthCubit>().state.name ?? 'Startup';

    return Scaffold(
      appBar: AppBar(title: const Text('Startup Profile')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          CircleAvatar(radius: 36, child: Text(name.isNotEmpty ? name[0].toUpperCase() : '?')),
          const SizedBox(height: 12),
          Text(name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          // TODO: pull real verification status from Firestore
          const Chip(
            label: Text('Pending Verification', style: TextStyle(fontSize: 12)),
            backgroundColor: Colors.orangeAccent,
          ),
          const SizedBox(height: 24),
          const ListTile(leading: Icon(Icons.business_outlined), title: Text('Startup Details')),
          const ListTile(leading: Icon(Icons.verified_outlined), title: Text('Verification Status')),
          const ListTile(leading: Icon(Icons.help_outline), title: Text('Help & Support')),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Logout', style: TextStyle(color: Colors.red)),
            onTap: () => context.read<AuthCubit>().logout(),
          ),
        ],
      ),
    );
  }
}
