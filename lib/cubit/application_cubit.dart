import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/application_model.dart';

enum ApplicationStatus { initial, loading, loaded, error }

class ApplicationState {
  final ApplicationStatus status;
  final List<ApplicationModel> applications;
  final String? errorMessage;

  const ApplicationState({
    this.status = ApplicationStatus.initial,
    this.applications = const [],
    this.errorMessage,
  });
}

class ApplicationCubit extends Cubit<ApplicationState> {
  final _db = FirebaseFirestore.instance;
  StreamSubscription? _subscription;

  ApplicationCubit() : super(const ApplicationState());

  // applications the current student has submitted.
  void loadMyApplications(String studentId) {
    emit(const ApplicationState(status: ApplicationStatus.loading));
    _subscription?.cancel();
    _subscription = _db
        .collection('applications')
        .where('studentId', isEqualTo: studentId)
        .orderBy('appliedAt', descending: true)
        .snapshots()
        .listen((snapshot) {
      final list = snapshot.docs
          .map((doc) => ApplicationModel.fromMap(doc.data(), doc.id))
          .toList();
      emit(ApplicationState(status: ApplicationStatus.loaded, applications: list));
    }, onError: (e) {
      emit(ApplicationState(status: ApplicationStatus.error, errorMessage: e.toString()));
    });
  }

  // Startup side: everyone who applied to any of this startup's postings.
  // Requires `startupId` to be stored directly on the application doc
  void loadApplicantsForStartup(String startupId) {
    emit(const ApplicationState(status: ApplicationStatus.loading));
    _subscription?.cancel();
    _subscription = _db
        .collection('applications')
        .where('startupId', isEqualTo: startupId)
        .orderBy('appliedAt', descending: true)
        .snapshots()
        .listen((snapshot) {
      final list = snapshot.docs
          .map((doc) => ApplicationModel.fromMap(doc.data(), doc.id))
          .toList();
      emit(ApplicationState(status: ApplicationStatus.loaded, applications: list));
    }, onError: (e) {
      emit(ApplicationState(status: ApplicationStatus.error, errorMessage: e.toString()));
    });
  }

  Future<void> apply(ApplicationModel application) async {
    await _db.collection('applications').add(application.toMap());
  }

  Future<void> updateStatus(String applicationId, String newStatus) async {
    await _db.collection('applications').doc(applicationId).update({'status': newStatus});
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
