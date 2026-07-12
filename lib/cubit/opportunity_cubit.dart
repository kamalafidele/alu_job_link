import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/opportunity_model.dart';

enum OpportunityStatus { initial, loading, loaded, error }

class OpportunityState {
  final OpportunityStatus status;
  final List<OpportunityModel> opportunities;
  final String? errorMessage;

  const OpportunityState({
    this.status = OpportunityStatus.initial,
    this.opportunities = const [],
    this.errorMessage,
  });
}

// Listens to Firestore in real time so new posted opportunity shows up for students instantly
class OpportunityCubit extends Cubit<OpportunityState> {
  final _db = FirebaseFirestore.instance;
  StreamSubscription? _subscription;

  OpportunityCubit() : super(const OpportunityState());

  // Student side: every opportunity from every startup, newest first.
  void loadAllOpportunities() {
    emit(const OpportunityState(status: OpportunityStatus.loading));
    _subscription?.cancel();
    _subscription = _db
        .collection('opportunities')
        .orderBy('postedAt', descending: true)
        .snapshots()
        .listen((snapshot) {
      final list = snapshot.docs
          .map((doc) => OpportunityModel.fromMap(doc.data(), doc.id))
          .toList();
      emit(OpportunityState(status: OpportunityStatus.loaded, opportunities: list));
    }, onError: (e) {
      emit(OpportunityState(status: OpportunityStatus.error, errorMessage: e.toString()));
    });
  }

  // Startup side: only opportunities this startup posted.
  void loadMyOpportunities(String startupId) {
    emit(const OpportunityState(status: OpportunityStatus.loading));
    _subscription?.cancel();
    _subscription = _db
        .collection('opportunities')
        .where('startupId', isEqualTo: startupId)
        .orderBy('postedAt', descending: true)
        .snapshots()
        .listen((snapshot) {
      final list = snapshot.docs
          .map((doc) => OpportunityModel.fromMap(doc.data(), doc.id))
          .toList();
      emit(OpportunityState(status: OpportunityStatus.loaded, opportunities: list));
    }, onError: (e) {
      emit(OpportunityState(status: OpportunityStatus.error, errorMessage: e.toString()));
    });
  }

  Future<void> postOpportunity(OpportunityModel opportunity) async {
    await _db.collection('opportunities').add(opportunity.toMap());
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
