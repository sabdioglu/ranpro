import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../business_profile/presentation/providers/business_providers.dart';
import '../../../services/presentation/providers/service_providers.dart';
import '../../domain/entities/staff_entity.dart';
import '../viewmodels/staff_view_model.dart';

class AddEditStaffScreen extends ConsumerStatefulWidget {
  final StaffEntity? staffToEdit;

  const AddEditStaffScreen({super.key, this.staffToEdit});

  @override
  ConsumerState<AddEditStaffScreen> createState() => _AddEditStaffScreenState();
}

class _AddEditStaffScreenState extends ConsumerState<AddEditStaffScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;
  late TextEditingController _positionController;
  
  List<String> _selectedServiceIds = [];

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(text: widget.staffToEdit?.firstName ?? '');
    _lastNameController = TextEditingController(text: widget.staffToEdit?.lastName ?? '');
    _phoneController = TextEditingController(text: widget.staffToEdit?.phone ?? '');
    _emailController = TextEditingController(text: widget.staffToEdit?.email ?? '');
    _positionController = TextEditingController(text: widget.staffToEdit?.position ?? '');
    
    if (widget.staffToEdit != null) {
      _selectedServiceIds = List<String>.from(widget.staffToEdit!.serviceIds);
    }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _positionController.dispose();
    super.dispose();
  }

  void _toggleService(String serviceId) {
    setState(() {
      if (_selectedServiceIds.contains(serviceId)) {
        _selectedServiceIds.remove(serviceId);
      } else {
        _selectedServiceIds.add(serviceId);
      }
    });
  }

  Future<void> _submit() async {
    if (_formKey.currentState?.validate() ?? false) {
      final currentBusiness = await ref.read(currentBusinessProvider.future);
      if (currentBusiness == null) return;

      final staff = StaffEntity(
        id: widget.staffToEdit?.id ?? '',
        businessId: currentBusiness.id,
        firstName: _firstNameController.text.trim(),
        lastName: _lastNameController.text.trim(),
        phone: _phoneController.text.trim(),
        email: _emailController.text.trim(),
        position: _positionController.text.trim(),
        serviceIds: _selectedServiceIds,
        isActive: widget.staffToEdit?.isActive ?? true,
      );

      if (widget.staffToEdit == null) {
        await ref.read(staffViewModelProvider.notifier).addStaff(staff);
      } else {
        await ref.read(staffViewModelProvider.notifier).updateStaff(staff);
      }

      if (mounted) {
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModelState = ref.watch(staffViewModelProvider);
    final servicesAsync = ref.watch(servicesProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.staffToEdit == null ? 'Yeni Personel Ekle' : 'Personel Düzenle'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppDimensions.spacing16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(AppDimensions.spacing16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Kişisel Bilgiler', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      const SizedBox(height: AppDimensions.spacing16),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _firstNameController,
                              decoration: const InputDecoration(labelText: 'Ad'),
                              validator: (value) => value == null || value.trim().isEmpty ? 'Zorunlu' : null,
                            ),
                          ),
                          const SizedBox(width: AppDimensions.spacing16),
                          Expanded(
                            child: TextFormField(
                              controller: _lastNameController,
                              decoration: const InputDecoration(labelText: 'Soyad'),
                              validator: (value) => value == null || value.trim().isEmpty ? 'Zorunlu' : null,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppDimensions.spacing16),
                      TextFormField(
                        controller: _positionController,
                        decoration: const InputDecoration(labelText: 'Pozisyon / Unvan (Opsiyonel)'),
                      ),
                      const SizedBox(height: AppDimensions.spacing16),
                      TextFormField(
                        controller: _phoneController,
                        decoration: const InputDecoration(labelText: 'Telefon Numarası (Opsiyonel)'),
                        keyboardType: TextInputType.phone,
                      ),
                      const SizedBox(height: AppDimensions.spacing16),
                      TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(labelText: 'E-posta (Opsiyonel)'),
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppDimensions.spacing16),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(AppDimensions.spacing16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Atanan Hizmetler', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      const SizedBox(height: AppDimensions.spacing8),
                      const Text(
                        'Personelin yapabildiği hizmetleri seçin.',
                        style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
                      ),
                      const SizedBox(height: AppDimensions.spacing16),
                      servicesAsync.when(
                        data: (services) {
                          if (services.isEmpty) return const Text('Önce hizmet eklemelisiniz.');
                          return Wrap(
                            spacing: 8.0,
                            runSpacing: 8.0,
                            children: services.map((service) {
                              final isSelected = _selectedServiceIds.contains(service.id);
                              return FilterChip(
                                label: Text(service.name),
                                selected: isSelected,
                                selectedColor: AppColors.primaryLight.withOpacity(0.3),
                                checkmarkColor: AppColors.primaryDark,
                                onSelected: (_) => _toggleService(service.id),
                              );
                            }).toList(),
                          );
                        },
                        loading: () => const CircularProgressIndicator(),
                        error: (_, __) => const Text('Hizmetler yüklenemedi.'),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppDimensions.spacing32),
              ElevatedButton(
                onPressed: viewModelState.isLoading ? null : _submit,
                child: viewModelState.isLoading
                    ? const SizedBox(height: 24, width: 24, child: CircularProgressIndicator(color: AppColors.surface, strokeWidth: 2))
                    : const Text('Kaydet'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
