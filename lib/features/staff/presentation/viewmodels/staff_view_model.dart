import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/errors/app_error.dart';
import '../../domain/entities/staff_entity.dart';
import '../providers/staff_providers.dart';

class StaffState {
  final bool isLoading;
  final String? error;
  final bool isSuccess;

  const StaffState({
    this.isLoading = false,
    this.error,
    this.isSuccess = false,
  });

  StaffState copyWith({
    bool? isLoading,
    String? error,
    bool? isSuccess,
  }) {
    return StaffState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}

class StaffViewModel extends StateNotifier<StaffState> {
  final Ref _ref;

  StaffViewModel(this._ref) : super(const StaffState());

  Future<void> addStaff(StaffEntity staff) async {
    state = state.copyWith(isLoading: true, error: null, isSuccess: false);
    try {
      final repository = _ref.read(staffRepositoryProvider);
      await repository.addStaff(staff);
      _ref.invalidate(staffListProvider);
      state = state.copyWith(isLoading: false, isSuccess: true);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: AppError(message: 'Personel eklenemedi.').message,
      );
    }
  }

  Future<void> updateStaff(StaffEntity staff) async {
    state = state.copyWith(isLoading: true, error: null, isSuccess: false);
    try {
      final repository = _ref.read(staffRepositoryProvider);
      await repository.updateStaff(staff);
      _ref.invalidate(staffListProvider);
      state = state.copyWith(isLoading: false, isSuccess: true);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: AppError(message: 'Personel güncellenemedi.').message,
      );
    }
  }

  Future<void> deleteStaff(String staffId) async {
    state = state.copyWith(isLoading: true, error: null, isSuccess: false);
    try {
      final repository = _ref.read(staffRepositoryProvider);
      await repository.deleteStaff(staffId);
      _ref.invalidate(staffListProvider);
      state = state.copyWith(isLoading: false, isSuccess: true);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: AppError(message: 'Personel silinemedi.').message,
      );
    }
  }
}

final staffViewModelProvider =
    StateNotifierProvider<StaffViewModel, StaffState>((ref) {
  return StaffViewModel(ref);
});
