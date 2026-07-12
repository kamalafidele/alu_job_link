import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/auth_cubit.dart';
import '../../cubit/opportunity_cubit.dart';
import '../../cubit/application_cubit.dart';
import 'startup_home_screen.dart';
import 'post_opportunity_screen.dart';
import 'applicants_screen.dart';
import 'startup_profile_screen.dart';

class StartupShell extends StatelessWidget {
  const StartupShell({super.key});

  @override
  Widget build(BuildContext context) {
    final uid = context.read<AuthCubit>().state.uid!;

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => OpportunityCubit()..loadMyOpportunities(uid)),
        BlocProvider(create: (_) => ApplicationCubit()..loadApplicantsForStartup(uid)),
      ],
      child: const _StartupShellBody(),
    );
  }
}

class _StartupShellBody extends StatefulWidget {
  const _StartupShellBody();

  @override
  State<_StartupShellBody> createState() => _StartupShellBodyState();
}

class _StartupShellBodyState extends State<_StartupShellBody> {
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
