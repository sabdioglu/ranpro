import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/errors/app_error.dart';
import '../../domain/entities/working_hours_entity.dart';
import '../providers/working_hours_providers.dart';

class WorkingHoursState {
  final bool isLoading;
  final String? error;
  final bool isSuccess;

  const WorkingHoursState({
    this.isLoading = false,
    this.error,
    this.isSuccess = false,
  });

  WorkingHoursState copyWith({
    bool? isLoading,
    String? error,
    bool? isSuccess,
  }) {
    return WorkingHoursState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}

class WorkingHoursViewModel extends StateNotifier<WorkingHoursState> {
  final Ref _ref;

  WorkingHoursViewModel(this._ref) : super(const WorkingHoursState());

  Future<void> saveWorkingHours(List<WorkingHoursEntity> workingHours, {String? staffId}) async {
    state = state.copyWith(isLoading: true, error: null, isSuccess: false);
    try {
      final repository = _ref.read(workingHoursRepositoryProvider);
      await repository.batchUpdateWorkingHours(workingHours);
      
      if (staffId == null) {
        _ref.invalidate(businessWorkingHoursProvider);
      } else {
        _ref.invalidate(staffWorkingHoursProvider(staffId));
      }
      
      state = state.copyWith(isLoading: false, isSuccess: true);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: AppError(message: 'Çalışma saatleri kaydedilemedi.').message,
      );
    }
  }
}

final workingHoursViewModelProvider =
    StateNotifierProvider<WorkingHoursViewModel, WorkingHoursState>((ref) {
  return WorkingHoursViewModel(ref);
});
