import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/errors/app_error.dart';
import '../../domain/entities/service_group.dart';
import '../providers/service_group_providers.dart';

class ServiceGroupsState {
  final bool isLoading;
  final String? error;
  final bool isSuccess;

  const ServiceGroupsState({
    this.isLoading = false,
    this.error,
    this.isSuccess = false,
  });

  ServiceGroupsState copyWith({
    bool? isLoading,
    String? error,
    bool? isSuccess,
  }) {
    return ServiceGroupsState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}

class ServiceGroupsViewModel extends StateNotifier<ServiceGroupsState> {
  final Ref _ref;

  ServiceGroupsViewModel(this._ref) : super(const ServiceGroupsState());

  Future<void> addGroup(ServiceGroup group) async {
    state = state.copyWith(isLoading: true, error: null, isSuccess: false);
    try {
      final repository = _ref.read(serviceGroupRepositoryProvider);
      await repository.addServiceGroup(group);
      _ref.invalidate(serviceGroupsProvider);
      state = state.copyWith(isLoading: false, isSuccess: true);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: AppError(message: 'Grup eklenemedi.').message,
      );
    }
  }

  Future<void> updateGroup(ServiceGroup group) async {
    state = state.copyWith(isLoading: true, error: null, isSuccess: false);
    try {
      final repository = _ref.read(serviceGroupRepositoryProvider);
      await repository.updateServiceGroup(group);
      _ref.invalidate(serviceGroupsProvider);
      state = state.copyWith(isLoading: false, isSuccess: true);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: AppError(message: 'Grup güncellenemedi.').message,
      );
    }
  }

  Future<void> deleteGroup(String groupId) async {
    state = state.copyWith(isLoading: true, error: null, isSuccess: false);
    try {
      final repository = _ref.read(serviceGroupRepositoryProvider);
      await repository.deleteServiceGroup(groupId);
      _ref.invalidate(serviceGroupsProvider);
      state = state.copyWith(isLoading: false, isSuccess: true);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: AppError(message: 'Grup silinemedi.').message,
      );
    }
  }
}

final serviceGroupsViewModelProvider =
    StateNotifierProvider<ServiceGroupsViewModel, ServiceGroupsState>((ref) {
  return ServiceGroupsViewModel(ref);
});
