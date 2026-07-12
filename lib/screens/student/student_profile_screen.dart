import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/auth_cubit.dart';

class StudentProfileScreen extends StatelessWidget {
  const StudentProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final name = context.watch<AuthCubit>().state.name ?? 'Student';

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          CircleAvatar(radius: 36, child: Text(name.isNotEmpty ? name[0].toUpperCase() : '?')),
          const SizedBox(height: 12),
          Text(name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          const ListTile(leading: Icon(Icons.person_outline), title: Text('My Profile')),
          const ListTile(leading: Icon(Icons.star_outline), title: Text('Skills & Interests')),
          const ListTile(leading: Icon(Icons.bookmark_outline), title: Text('Saved Opportunities')),
          const ListTile(leading: Icon(Icons.notifications_outlined), title: Text('Notifications')),
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
