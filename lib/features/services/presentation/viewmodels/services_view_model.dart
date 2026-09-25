import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/errors/app_error.dart';
import '../../domain/entities/service_entity.dart';
import '../providers/service_providers.dart';

class ServicesState {
  final bool isLoading;
  final String? error;
  final bool isSuccess;

  const ServicesState({
    this.isLoading = false,
    this.error,
    this.isSuccess = false,
  });

  ServicesState copyWith({
    bool? isLoading,
    String? error,
    bool? isSuccess,
  }) {
    return ServicesState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}

class ServicesViewModel extends StateNotifier<ServicesState> {
  final Ref _ref;

  ServicesViewModel(this._ref) : super(const ServicesState());

  Future<void> addService(ServiceEntity service) async {
    state = state.copyWith(isLoading: true, error: null, isSuccess: false);
    try {
      final repository = _ref.read(serviceRepositoryProvider);
      await repository.addService(service);
      _ref.invalidate(servicesProvider);
      state = state.copyWith(isLoading: false, isSuccess: true);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: AppError(message: 'Hizmet eklenemedi.').message,
      );
    }
  }

  Future<void> updateService(ServiceEntity service) async {
    state = state.copyWith(isLoading: true, error: null, isSuccess: false);
    try {
      final repository = _ref.read(serviceRepositoryProvider);
      await repository.updateService(service);
      _ref.invalidate(servicesProvider);
      state = state.copyWith(isLoading: false, isSuccess: true);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: AppError(message: 'Hizmet güncellenemedi.').message,
      );
    }
  }

  Future<void> deleteService(String serviceId) async {
    state = state.copyWith(isLoading: true, error: null, isSuccess: false);
    try {
      final repository = _ref.read(serviceRepositoryProvider);
      await repository.deleteService(serviceId);
      _ref.invalidate(servicesProvider);
      state = state.copyWith(isLoading: false, isSuccess: true);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: AppError(message: 'Hizmet silinemedi.').message,
      );
    }
  }
}

final servicesViewModelProvider =
    StateNotifierProvider<ServicesViewModel, ServicesState>((ref) {
  return ServicesViewModel(ref);
});
