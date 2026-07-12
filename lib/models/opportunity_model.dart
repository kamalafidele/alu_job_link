import 'package:cloud_firestore/cloud_firestore.dart';

// Represents an internship/opportunity posted by a startup.
class OpportunityModel {
  final String id;
  final String title;
  final String startupId;
  final String startupName;
  final String description;
  final String category; // Design, Engineering, Marketing
  final String commitment;
  final List<String> skills;
  final DateTime postedAt;

  OpportunityModel({
    required this.id,
    required this.title,
    required this.startupId,
    required this.startupName,
    required this.description,
    required this.category,
    required this.commitment,
    required this.skills,
    required this.postedAt,
  });

  factory OpportunityModel.fromMap(Map<String, dynamic> map, String id) {
    return OpportunityModel(
      id: id,
      title: map['title'] ?? '',
      startupId: map['startupId'] ?? '',
      startupName: map['startupName'] ?? '',
      description: map['description'] ?? '',
      category: map['category'] ?? 'Other',
      commitment: map['commitment'] ?? '',
      skills: List<String>.from(map['skills'] ?? []),
      // Firestore stores dates as Timestamp, not DateTime - convert on read.
      postedAt: (map['postedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'startupId': startupId,
      'startupName': startupName,
      'description': description,
      'category': category,
      'commitment': commitment,
      'skills': skills,
      'postedAt': postedAt,
    };
  }
}
