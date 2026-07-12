import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/auth_cubit.dart';
import '../../cubit/opportunity_cubit.dart';
import '../../cubit/application_cubit.dart';
import 'student_home_screen.dart';
import 'explore_screen.dart';
import 'applications_screen.dart';
import 'student_profile_screen.dart';

// OpportunityCubit and ApplicationCubit are created ONCE here (not per
// screen) so switching tabs doesn't re-fetch data or lose scroll state
class StudentShell extends StatelessWidget {
  const StudentShell({super.key});

  @override
  Widget build(BuildContext context) {
    final uid = context.read<AuthCubit>().state.uid!;

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => OpportunityCubit()..loadAllOpportunities()),
        BlocProvider(create: (_) => ApplicationCubit()..loadMyApplications(uid)),
      ],
      child: const _StudentShellBody(),
    );
  }
}

class _StudentShellBody extends StatefulWidget {
  const _StudentShellBody();

  @override
  State<_StudentShellBody> createState() => _StudentShellBodyState();
}

class _StudentShellBodyState extends State<_StudentShellBody> {
  int _index = 0;

  final _screens = const [
    StudentHomeScreen(),
    ExploreScreen(),
    ApplicationsScreen(),
    StudentProfileScreen(),
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
          NavigationDestination(icon: Icon(Icons.search_outlined), selectedIcon: Icon(Icons.search), label: 'Explore'),
          NavigationDestination(icon: Icon(Icons.list_alt_outlined), selectedIcon: Icon(Icons.list_alt), label: 'Applications'),
          NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
