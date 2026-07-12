import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/auth_cubit.dart';

class StartupProfileScreen extends StatelessWidget {
  const StartupProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthCubit>().state;
    final name = auth.name ?? 'Startup';

    return Scaffold(
      appBar: AppBar(title: const Text('Startup Profile')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          CircleAvatar(radius: 36, child: Text(name.isNotEmpty ? name[0].toUpperCase() : '?')),
          const SizedBox(height: 12),
          Text(name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          Chip(
            label: Text(
              auth.verified ? 'Verified' : 'Pending Verification',
              style: const TextStyle(fontSize: 12, color: Colors.white),
            ),
            backgroundColor: auth.verified ? Colors.green : Colors.orangeAccent,
          ),
          if (!auth.verified) ...[
            const SizedBox(height: 12),
            OutlinedButton(
              onPressed: () {
                context.read<AuthCubit>().requestVerification();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Verification requested. An admin will review your account.')),
                );
              },
              child: const Text('Request Verification'),
            ),
          ],
          const SizedBox(height: 24),
          const ListTile(leading: Icon(Icons.business_outlined), title: Text('Startup Details')),
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
