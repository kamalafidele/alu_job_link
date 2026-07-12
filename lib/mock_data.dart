import 'models/opportunity_model.dart';
import 'models/application_model.dart';

final List<OpportunityModel> mockOpportunities = [
  OpportunityModel(
    id: '1',
    title: 'UX Research Volunteer',
    startupId: 's1',
    startupName: 'EduBridge',
    description: 'Help us understand student needs through interviews and '
        'usability testing on our new learning platform.',
    category: 'Design',
    commitment: 'Volunteer (4-6 hrs/week)',
    skills: ['UX Design', 'Research', 'Remote'],
    postedAt: DateTime.now().subtract(const Duration(days: 2)),
  ),
  OpportunityModel(
    id: '2',
    title: 'Flutter Developer',
    startupId: 's2',
    startupName: 'Learnify',
    description: 'Build features for our mobile app used by ALU students to '
        'track their learning goals.',
    category: 'Engineering',
    commitment: 'Part-time (8-10 hrs/week)',
    skills: ['Flutter', 'Dart', 'Firebase'],
    postedAt: DateTime.now().subtract(const Duration(days: 3)),
  ),
  OpportunityModel(
    id: '3',
    title: 'Social Media Assistant',
    startupId: 's3',
    startupName: 'GreenLoop',
    description: 'Manage our Instagram and TikTok presence and grow our '
        'campus audience.',
    category: 'Marketing',
    commitment: 'Part-time - Kigali',
    skills: ['Content Creation', 'Social Media'],
    postedAt: DateTime.now().subtract(const Duration(days: 6)),
  ),
];

final List<ApplicationModel> mockApplications = [
  ApplicationModel(
    id: 'a1',
    opportunityId: '2',
    opportunityTitle: 'Flutter Developer',
    startupName: 'Learnify',
    studentId: 'u1',
    status: 'interview',
    appliedAt: DateTime.now().subtract(const Duration(days: 3)),
  ),
  ApplicationModel(
    id: 'a2',
    opportunityId: '1',
    opportunityTitle: 'UX Research Volunteer',
    startupName: 'EduBridge',
    studentId: 'u1',
    status: 'accepted',
    appliedAt: DateTime.now().subtract(const Duration(days: 7)),
  ),
];
