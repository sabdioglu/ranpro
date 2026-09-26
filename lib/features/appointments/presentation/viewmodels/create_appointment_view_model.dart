import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreateAppointmentState {
  final int currentStep;
  final String? selectedServiceId;
  final String? selectedStaffId;
  final DateTime? selectedDate;
  final String? selectedTime; // "14:30" formatında
  final String? selectedCustomerId;
  final String? notes;
  final bool isLoading;
  final String? error;

  const CreateAppointmentState({
    this.currentStep = 0,
    this.selectedServiceId,
    this.selectedStaffId,
    this.selectedDate,
    this.selectedTime,
    this.selectedCustomerId,
    this.notes,
    this.isLoading = false,
    this.error,
  });

  CreateAppointmentState copyWith({
    int? currentStep,
    String? selectedServiceId,
    String? selectedStaffId,
    DateTime? selectedDate,
    String? selectedTime,
    String? selectedCustomerId,
    String? notes,
    bool? isLoading,
    String? error,
  }) {
    return CreateAppointmentState(
      currentStep: currentStep ?? this.currentStep,
      selectedServiceId: selectedServiceId ?? this.selectedServiceId,
      selectedStaffId: selectedStaffId ?? this.selectedStaffId,
      selectedDate: selectedDate ?? this.selectedDate,
      selectedTime: selectedTime ?? this.selectedTime,
      selectedCustomerId: selectedCustomerId ?? this.selectedCustomerId,
      notes: notes ?? this.notes,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class CreateAppointmentViewModel extends StateNotifier<CreateAppointmentState> {
  CreateAppointmentViewModel() : super(const CreateAppointmentState());

  void nextStep() {
    state = state.copyWith(currentStep: state.currentStep + 1);
  }

  void previousStep() {
    if (state.currentStep > 0) {
      state = state.copyWith(currentStep: state.currentStep - 1);
    }
  }

  void selectService(String serviceId) {
    state = state.copyWith(selectedServiceId: serviceId);
    nextStep();
  }

  void selectStaff(String staffId) {
    state = state.copyWith(selectedStaffId: staffId);
    nextStep();
  }

  void selectDate(DateTime date) {
    state = state.copyWith(selectedDate: date);
  }

  void selectTime(String time) {
    state = state.copyWith(selectedTime: time);
    nextStep();
  }

  void selectCustomer(String customerId) {
    state = state.copyWith(selectedCustomerId: customerId);
    nextStep();
  }

  void setNotes(String notes) {
    state = state.copyWith(notes: notes);
  }

  Future<void> createAppointment() async {
    // TODO: STAGE 16 - Availability Engine sonrası tam kayıt işlemi yapılacak.
    state = state.copyWith(isLoading: true, error: null);
    await Future.delayed(const Duration(seconds: 1)); // Mock delay
    // Kayıt mantığı repository üzerinden yapılacak.
    state = state.copyWith(isLoading: false);
  }
}

final createAppointmentViewModelProvider =
    StateNotifierProvider.autoDispose<CreateAppointmentViewModel, CreateAppointmentState>((ref) {
  return CreateAppointmentViewModel();
});
