import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../business_profile/presentation/providers/business_providers.dart';
import '../../domain/entities/customer_entity.dart';
import '../viewmodels/customers_view_model.dart';

class AddEditCustomerScreen extends ConsumerStatefulWidget {
  final CustomerEntity? customerToEdit;

  const AddEditCustomerScreen({super.key, this.customerToEdit});

  @override
  ConsumerState<AddEditCustomerScreen> createState() => _AddEditCustomerScreenState();
}

class _AddEditCustomerScreenState extends ConsumerState<AddEditCustomerScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;
  late TextEditingController _notesController;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(text: widget.customerToEdit?.firstName ?? '');
    _lastNameController = TextEditingController(text: widget.customerToEdit?.lastName ?? '');
    _phoneController = TextEditingController(text: widget.customerToEdit?.phone ?? '');
    _emailController = TextEditingController(text: widget.customerToEdit?.email ?? '');
    _notesController = TextEditingController(text: widget.customerToEdit?.notes ?? '');
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_formKey.currentState?.validate() ?? false) {
      final currentBusiness = await ref.read(currentBusinessProvider.future);
      if (currentBusiness == null) return;

      final customer = CustomerEntity(
        id: widget.customerToEdit?.id ?? '',
        businessId: currentBusiness.id,
        firstName: _firstNameController.text.trim(),
        lastName: _lastNameController.text.trim(),
        phone: _phoneController.text.trim(),
        email: _emailController.text.trim(),
        notes: _notesController.text.trim(),
        totalVisits: widget.customerToEdit?.totalVisits ?? 0,
        totalSpent: widget.customerToEdit?.totalSpent ?? 0,
        createdAt: widget.customerToEdit?.createdAt ?? DateTime.now(),
        lastVisitAt: widget.customerToEdit?.lastVisitAt,
        isActive: widget.customerToEdit?.isActive ?? true,
      );

      if (widget.customerToEdit == null) {
        await ref.read(customersViewModelProvider.notifier).addCustomer(customer);
      } else {
        await ref.read(customersViewModelProvider.notifier).updateCustomer(customer);
      }

      if (mounted) {
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModelState = ref.watch(customersViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.customerToEdit == null ? 'Yeni Müşteri' : 'Müşteri Düzenle'),
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
                        controller: _phoneController,
                        decoration: const InputDecoration(labelText: 'Telefon Numarası'),
                        keyboardType: TextInputType.phone,
                        validator: (value) => value == null || value.trim().isEmpty ? 'Zorunlu' : null,
                      ),
                      const SizedBox(height: AppDimensions.spacing16),
                      TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(labelText: 'E-posta (Opsiyonel)'),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: AppDimensions.spacing16),
                      TextFormField(
                        controller: _notesController,
                        decoration: const InputDecoration(labelText: 'Müşteri Notu (Opsiyonel)'),
                        maxLines: 3,
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
