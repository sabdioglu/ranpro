import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/errors/app_error.dart';
import '../../domain/entities/customer_entity.dart';
import '../providers/customer_providers.dart';

class CustomersState {
  final bool isLoading;
  final String? error;
  final bool isSuccess;

  const CustomersState({
    this.isLoading = false,
    this.error,
    this.isSuccess = false,
  });

  CustomersState copyWith({
    bool? isLoading,
    String? error,
    bool? isSuccess,
  }) {
    return CustomersState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}

class CustomersViewModel extends StateNotifier<CustomersState> {
  final Ref _ref;

  CustomersViewModel(this._ref) : super(const CustomersState());

  Future<void> addCustomer(CustomerEntity customer) async {
    state = state.copyWith(isLoading: true, error: null, isSuccess: false);
    try {
      final repository = _ref.read(customerRepositoryProvider);
      await repository.addCustomer(customer);
      _ref.invalidate(customersListProvider);
      state = state.copyWith(isLoading: false, isSuccess: true);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: AppError(message: 'Müşteri eklenemedi.').message,
      );
    }
  }

  Future<void> updateCustomer(CustomerEntity customer) async {
    state = state.copyWith(isLoading: true, error: null, isSuccess: false);
    try {
      final repository = _ref.read(customerRepositoryProvider);
      await repository.updateCustomer(customer);
      _ref.invalidate(customersListProvider);
      state = state.copyWith(isLoading: false, isSuccess: true);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: AppError(message: 'Müşteri güncellenemedi.').message,
      );
    }
  }

  Future<void> deleteCustomer(String customerId) async {
    state = state.copyWith(isLoading: true, error: null, isSuccess: false);
    try {
      final repository = _ref.read(customerRepositoryProvider);
      await repository.deleteCustomer(customerId);
      _ref.invalidate(customersListProvider);
      state = state.copyWith(isLoading: false, isSuccess: true);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: AppError(message: 'Müşteri silinemedi.').message,
      );
    }
  }
}

final customersViewModelProvider =
    StateNotifierProvider<CustomersViewModel, CustomersState>((ref) {
  return CustomersViewModel(ref);
});
