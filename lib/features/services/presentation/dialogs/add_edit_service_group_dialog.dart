import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../business_profile/presentation/providers/business_providers.dart';
import '../../domain/entities/service_group.dart';
import '../viewmodels/service_groups_view_model.dart';

class AddEditServiceGroupDialog extends ConsumerStatefulWidget {
  final ServiceGroup? groupToEdit;

  const AddEditServiceGroupDialog({super.key, this.groupToEdit});

  @override
  ConsumerState<AddEditServiceGroupDialog> createState() => _AddEditServiceGroupDialogState();
}

class _AddEditServiceGroupDialogState extends ConsumerState<AddEditServiceGroupDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _orderController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.groupToEdit?.name ?? '');
    _orderController = TextEditingController(
      text: widget.groupToEdit != null ? widget.groupToEdit!.order.toString() : '0',
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _orderController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_formKey.currentState?.validate() ?? false) {
      final currentBusiness = await ref.read(currentBusinessProvider.future);
      if (currentBusiness == null) return;

      final int order = int.tryParse(_orderController.text) ?? 0;

      final group = ServiceGroup(
        id: widget.groupToEdit?.id ?? '',
        businessId: currentBusiness.id,
        name: _nameController.text.trim(),
        order: order,
        isActive: widget.groupToEdit?.isActive ?? true,
      );

      if (widget.groupToEdit == null) {
        await ref.read(serviceGroupsViewModelProvider.notifier).addGroup(group);
      } else {
        await ref.read(serviceGroupsViewModelProvider.notifier).updateGroup(group);
      }

      if (mounted) {
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModelState = ref.watch(serviceGroupsViewModelProvider);

    return AlertDialog(
      title: Text(widget.groupToEdit == null ? 'Yeni Grup Ekle' : 'Grubu Düzenle'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Grup Adı'),
                validator: (value) => value == null || value.trim().isEmpty ? 'Zorunlu alan' : null,
              ),
              const SizedBox(height: AppDimensions.spacing16),
              TextFormField(
                controller: _orderController,
                decoration: const InputDecoration(labelText: 'Sıralama Numarası'),
                keyboardType: TextInputType.number,
                validator: (value) => value == null || int.tryParse(value) == null ? 'Geçerli bir sayı girin' : null,
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
