import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../viewmodels/create_appointment_view_model.dart';
import '../../../services/presentation/providers/service_providers.dart';
import '../../../staff/presentation/providers/staff_providers.dart';
import '../../../customers/presentation/providers/customer_providers.dart';

class CreateAppointmentScreen extends ConsumerWidget {
  const CreateAppointmentScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(createAppointmentViewModelProvider);
    final notifier = ref.read(createAppointmentViewModelProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Yeni Randevu'),
      ),
      body: Stepper(
        currentStep: state.currentStep,
        onStepCancel: notifier.previousStep,
        onStepContinue: () {
          if (state.currentStep == 5) {
            notifier.createAppointment(); // Son aşama
          } else {
            notifier.nextStep();
          }
        },
        onStepTapped: (index) {
          // Geriye dönük adımlara tıklanabilmesine izin ver
          if (index < state.currentStep) {
            // State'i doğrudan güncellemiyoruz, notifier üzerinden yapılabilir
          }
        },
        steps: [
          Step(
            title: const Text('Hizmet Seçimi'),
            isActive: state.currentStep >= 0,
            state: state.currentStep > 0 ? StepState.complete : StepState.indexed,
            content: _ServiceSelectionStep(ref: ref),
          ),
          Step(
            title: const Text('Personel Seçimi'),
            isActive: state.currentStep >= 1,
            state: state.currentStep > 1 ? StepState.complete : StepState.indexed,
            content: _StaffSelectionStep(ref: ref),
          ),
          Step(
            title: const Text('Tarih & Saat'),
            isActive: state.currentStep >= 2,
            state: state.currentStep > 2 ? StepState.complete : StepState.indexed,
            content: const Text('Tarih ve Saat Seçimi (Stage 16 Availability Engine ile eklenecek)'),
          ),
          Step(
            title: const Text('Müşteri Seçimi'),
            isActive: state.currentStep >= 3,
            state: state.currentStep > 3 ? StepState.complete : StepState.indexed,
            content: _CustomerSelectionStep(ref: ref),
          ),
          Step(
            title: const Text('Notlar (Opsiyonel)'),
            isActive: state.currentStep >= 4,
            state: state.currentStep > 4 ? StepState.complete : StepState.indexed,
            content: TextFormField(
              decoration: const InputDecoration(labelText: 'Randevu Notu'),
              onChanged: notifier.setNotes,
            ),
          ),
          Step(
            title: const Text('Özet & Onay'),
            isActive: state.currentStep >= 5,
            content: const Text('Randevu özeti burada gösterilecek.'),
          ),
        ],
      ),
    );
  }
}

// Private widget'lar ile Step içerikleri ayrıştırılmıştır (Single Responsibility).
class _ServiceSelectionStep extends StatelessWidget {
  final WidgetRef ref;
  const _ServiceSelectionStep({required this.ref});

  @override
  Widget build(BuildContext context) {
    final servicesAsync = ref.watch(servicesProvider);
    final notifier = ref.read(createAppointmentViewModelProvider.notifier);
    final state = ref.watch(createAppointmentViewModelProvider);

    return servicesAsync.when(
      data: (services) => Column(
        children: services.map((s) => RadioListTile<String>(
          title: Text(s.name),
          value: s.id,
          groupValue: state.selectedServiceId,
          onChanged: (val) => notifier.selectService(val!),
        )).toList(),
      ),
      loading: () => const CircularProgressIndicator(),
      error: (e, _) => Text('Hata: $e'),
    );
  }
}

class _StaffSelectionStep extends StatelessWidget {
  final WidgetRef ref;
  const _StaffSelectionStep({required this.ref});

  @override
  Widget build(BuildContext context) {
    final staffAsync = ref.watch(staffListProvider);
    final notifier = ref.read(createAppointmentViewModelProvider.notifier);
    final state = ref.watch(createAppointmentViewModelProvider);

    return staffAsync.when(
      data: (staffList) => Column(
        children: staffList.map((s) => RadioListTile<String>(
          title: Text(s.fullName),
          value: s.id,
          groupValue: state.selectedStaffId,
          onChanged: (val) => notifier.selectStaff(val!),
        )).toList(),
      ),
      loading: () => const CircularProgressIndicator(),
      error: (e, _) => Text('Hata: $e'),
    );
  }
}

class _CustomerSelectionStep extends StatelessWidget {
  final WidgetRef ref;
  const _CustomerSelectionStep({required this.ref});

  @override
  Widget build(BuildContext context) {
    final customersAsync = ref.watch(customersListProvider);
    final notifier = ref.read(createAppointmentViewModelProvider.notifier);
    final state = ref.watch(createAppointmentViewModelProvider);

    return customersAsync.when(
      data: (customers) => Column(
        children: customers.map((c) => RadioListTile<String>(
          title: Text(c.fullName),
          subtitle: Text(c.phone),
          value: c.id,
          groupValue: state.selectedCustomerId,
          onChanged: (val) => notifier.selectCustomer(val!),
        )).toList(),
      ),
      loading: () => const CircularProgressIndicator(),
      error: (e, _) => Text('Hata: $e'),
    );
  }
}
