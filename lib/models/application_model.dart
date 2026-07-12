class ApplicationModel {
  final String id;
  final String opportunityId;
  final String opportunityTitle;
  final String startupName;
  final String studentId;
  final String status; // applied, interview, accepted, rejected
  final DateTime appliedAt;

  ApplicationModel({
    required this.id,
    required this.opportunityId,
    required this.opportunityTitle,
    required this.startupName,
    required this.studentId,
    required this.status,
    required this.appliedAt,
  });

  factory ApplicationModel.fromMap(Map<String, dynamic> map, String id) {
    return ApplicationModel(
      id: id,
      opportunityId: map['opportunityId'] ?? '',
      opportunityTitle: map['opportunityTitle'] ?? '',
      startupName: map['startupName'] ?? '',
      studentId: map['studentId'] ?? '',
      status: map['status'] ?? 'applied',
      appliedAt: (map['appliedAt'] as DateTime?) ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'opportunityId': opportunityId,
      'opportunityTitle': opportunityTitle,
      'startupName': startupName,
      'studentId': studentId,
      'status': status,
      'appliedAt': appliedAt,
    };
  }
}
