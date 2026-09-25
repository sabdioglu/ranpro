import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../business_profile/presentation/providers/business_providers.dart';
import '../../domain/entities/service_entity.dart';
import '../viewmodels/services_view_model.dart';

class AddEditServiceDialog extends ConsumerStatefulWidget {
  final ServiceEntity? serviceToEdit;

  const AddEditServiceDialog({super.key, this.serviceToEdit});

  @override
  ConsumerState<AddEditServiceDialog> createState() => _AddEditServiceDialogState();
}

class _AddEditServiceDialogState extends ConsumerState<AddEditServiceDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _durationController;
  late TextEditingController _priceController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.serviceToEdit?.name ?? '');
    _durationController = TextEditingController(
      text: widget.serviceToEdit != null ? widget.serviceToEdit!.durationInMinutes.toString() : '30',
    );
    // Kuruş formatını UI için double formatına (ör: 150.00) çevir
    _priceController = TextEditingController(
      text: widget.serviceToEdit != null ? (widget.serviceToEdit!.price / 100).toStringAsFixed(2) : '',
    );
    _descriptionController = TextEditingController(text: widget.serviceToEdit?.description ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _durationController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_formKey.currentState?.validate() ?? false) {
      final currentBusiness = await ref.read(currentBusinessProvider.future);
      if (currentBusiness == null) return;

      // UI formatından (double) kuruş formatına (int) çevir
      final double parsedPrice = double.tryParse(_priceController.text.replaceAll(',', '.')) ?? 0.0;
      final int priceInKurus = (parsedPrice * 100).round();
      final int duration = int.tryParse(_durationController.text) ?? 30;

      final service = ServiceEntity(
        id: widget.serviceToEdit?.id ?? '',
        businessId: currentBusiness.id,
        name: _nameController.text.trim(),
        description: _descriptionController.text.trim(),
        durationInMinutes: duration,
        price: priceInKurus,
        isActive: widget.serviceToEdit?.isActive ?? true,
      );

      if (widget.serviceToEdit == null) {
        await ref.read(servicesViewModelProvider.notifier).addService(service);
      } else {
        await ref.read(servicesViewModelProvider.notifier).updateService(service);
      }

      if (mounted) {
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModelState = ref.watch(servicesViewModelProvider);

    return AlertDialog(
      title: Text(widget.serviceToEdit == null ? 'Yeni Hizmet Ekle' : 'Hizmeti Düzenle'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Hizmet Adı'),
                validator: (value) => value == null || value.trim().isEmpty ? 'Zorunlu alan' : null,
              ),
              const SizedBox(height: AppDimensions.spacing16),
              TextFormField(
                controller: _durationController,
                decoration: const InputDecoration(labelText: 'Süre (Dakika)'),
                keyboardType: TextInputType.number,
                validator: (value) => value == null || int.tryParse(value) == null ? 'Geçerli bir süre girin' : null,
              ),
              const SizedBox(height: AppDimensions.spacing16),
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(labelText: 'Fiyat (₺)', hintText: '0.00'),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) return 'Zorunlu alan';
                  if (double.tryParse(value.replaceAll(',', '.')) == null) return 'Geçerli bir fiyat girin';
                  return null;
                },
              ),
              const SizedBox(height: AppDimensions.spacing16),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Açıklama (Opsiyonel)'),
                maxLines: 2,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: viewModelState.isLoading ? null : () => Navigator.of(context).pop(),
          child: const Text('İptal'),
        ),
        ElevatedButton(
          onPressed: viewModelState.isLoading ? null : _submit,
          child: viewModelState.isLoading
              ? const SizedBox(height: 16, width: 16, child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.surface))
              : const Text('Kaydet'),
        ),
      ],
    );
  }
}
