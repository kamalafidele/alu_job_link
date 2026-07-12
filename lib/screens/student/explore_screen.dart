import 'package:flutter/material.dart';
import '../../mock_data.dart';
import '../../widgets/opportunity_card.dart';
import 'opportunity_details_screen.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  String _selectedCategory = 'All';

  static const categories = ['All', 'Design', 'Engineering', 'Marketing', 'Other'];

  @override
  Widget build(BuildContext context) {
    final filtered = _selectedCategory == 'All'
        ? mockOpportunities
        : mockOpportunities
        .where((o) => o.category == _selectedCategory)
        .toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Explore')),
      body: Column(
        children: [
          SizedBox(
            height: 48,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              children: categories.map((cat) {
                final selected = cat == _selectedCategory;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: ChoiceChip(
                    label: Text(cat),
                    selected: selected,
                    onSelected: (_) => setState(() => _selectedCategory = cat),
                  ),
                );
              }).toList(),
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: filtered.isEmpty
                ? const Center(child: Text('No opportunities in this category yet.'))
                : ListView(
              padding: const EdgeInsets.all(16),
              children: filtered
                  .map((opp) => OpportunityCard(
                opportunity: opp,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          OpportunityDetailsScreen(opportunity: opp),
                    ),
                  );
                },
              ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
