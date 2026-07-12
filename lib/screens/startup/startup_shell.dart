import 'package:flutter/material.dart';
import 'startup_home_screen.dart';
import 'post_opportunity_screen.dart';
import 'applicants_screen.dart';
import 'startup_profile_screen.dart';

class StartupShell extends StatefulWidget {
  const StartupShell({super.key});

  @override
  State<StartupShell> createState() => _StartupShellState();
}

class _StartupShellState extends State<StartupShell> {
  int _index = 0;

  final _screens = const [
    StartupHomeScreen(),
    PostOpportunityScreen(),
    ApplicantsScreen(),
    StartupProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _index, children: _screens),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.add_box_outlined), selectedIcon: Icon(Icons.add_box), label: 'Post'),
          NavigationDestination(icon: Icon(Icons.people_outline), selectedIcon: Icon(Icons.people), label: 'Applicants'),
          NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
