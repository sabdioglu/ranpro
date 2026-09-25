import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/errors/app_error.dart';
import '../../domain/entities/business.dart';
import '../providers/business_providers.dart';

class BusinessProfileState {
  final bool isLoading;
  final String? error;
  final bool isSuccess;

  const BusinessProfileState({
    this.isLoading = false,
    this.error,
    this.isSuccess = false,
  });

  BusinessProfileState copyWith({
    bool? isLoading,
    String? error,
    bool? isSuccess,
  }) {
    return BusinessProfileState(
      isLoading: isLoading ?? this.isLoading,
      error: error, // Error null geçilebilmeli
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}

class BusinessProfileViewModel extends StateNotifier<BusinessProfileState> {
  final Ref _ref;

  BusinessProfileViewModel(this._ref) : super(const BusinessProfileState());

  Future<void> updateProfile(Business updatedBusiness) async {
    state = state.copyWith(isLoading: true, error: null, isSuccess: false);
    try {
      final repository = _ref.read(businessRepositoryProvider);
      await repository.updateBusiness(updatedBusiness);
      
      // Profil güncellendikten sonra mevcut işletme provider'ını yenile (invalidate)
      _ref.invalidate(currentBusinessProvider);
      
      state = state.copyWith(isLoading: false, isSuccess: true);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: AppError(message: 'İşletme bilgileri güncellenemedi.').message,
      );
    }
  }
}

final businessProfileViewModelProvider =
    StateNotifierProvider<BusinessProfileViewModel, BusinessProfileState>((ref) {
  return BusinessProfileViewModel(ref);
});
