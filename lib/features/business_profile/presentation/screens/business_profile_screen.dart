import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../domain/entities/business.dart';
import '../providers/business_providers.dart';
import '../viewmodels/business_profile_view_model.dart';

class BusinessProfileScreen extends ConsumerStatefulWidget {
  const BusinessProfileScreen({super.key});

  @override
  ConsumerState<BusinessProfileScreen> createState() => _BusinessProfileScreenState();
}

class _BusinessProfileScreenState extends ConsumerState<BusinessProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _addressController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _phoneController = TextEditingController();
    _addressController = TextEditingController();
    _descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _initFormValues(Business business) {
    if (_nameController.text.isEmpty) {
      _nameController.text = business.name;
      _phoneController.text = business.phone ?? '';
      _addressController.text = business.address ?? '';
      _descriptionController.text = business.description ?? '';
    }
  }

  void _saveProfile(Business currentBusiness) {
    if (_formKey.currentState?.validate() ?? false) {
      final updatedBusiness = Business(
        id: currentBusiness.id,
        name: _nameController.text.trim(),
        phone: _phoneController.text.trim(),
        address: _addressController.text.trim(),
        description: _descriptionController.text.trim(),
        logoUrl: currentBusiness.logoUrl,
        isActive: currentBusiness.isActive,
      );
      
      ref.read(businessProfileViewModelProvider.notifier).updateProfile(updatedBusiness);
    }
  }

  @override
  Widget build(BuildContext context) {
    final businessAsyncValue = ref.watch(currentBusinessProvider);
    final viewModelState = ref.watch(businessProfileViewModelProvider);

    // İşlem başarılı olduğunda Snackbar gösterimi (Build sonrasına ertelenir)
    ref.listen<BusinessProfileState>(businessProfileViewModelProvider, (previous, next) {
      if (next.isSuccess && (previous?.isSuccess != true)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('İşletme bilgileri başarıyla güncellendi.'), backgroundColor: AppColors.success),
        );
      }
      if (next.error != null && next.error != previous?.error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.error!), backgroundColor: AppColors.error),
        );
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('İşletme Bilgileri'),
      ),
      body: businessAsyncValue.when(
        data: (business) {
          if (business == null) {
            return const Center(child: Text('İşletme kaydı bulunamadı.'));
          }

          _initFormValues(business);

          return SingleChildScrollView(
            padding: const EdgeInsets.all(AppDimensions.spacing16),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(AppDimensions.spacing16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(labelText: 'İşletme Adı'),
                        validator: (value) =>
                            value == null || value.isEmpty ? 'İşletme adı gerekli' : null,
                      ),
                      const SizedBox(height: AppDimensions.spacing16),
                      TextFormField(
                        controller: _phoneController,
                        decoration: const InputDecoration(labelText: 'Telefon Numarası'),
                        keyboardType: TextInputType.phone,
                      ),
                      const SizedBox(height: AppDimensions.spacing16),
                      TextFormField(
                        controller: _addressController,
                        decoration: const InputDecoration(labelText: 'Adres'),
                        maxLines: 2,
                      ),
                      const SizedBox(height: AppDimensions.spacing16),
                      TextFormField(
                        controller: _descriptionController,
                        decoration: const InputDecoration(labelText: 'Hakkımızda / Açıklama'),
                        maxLines: 3,
                      ),
                      const SizedBox(height: AppDimensions.spacing32),
                      ElevatedButton(
                        onPressed: viewModelState.isLoading ? null : () => _saveProfile(business),
                        child: viewModelState.isLoading
                            ? const SizedBox(
                                height: 24,
                                width: 24,
                                child: CircularProgressIndicator(color: AppColors.surface, strokeWidth: 2),
                              )
                            : const Text('Kaydet'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator(color: AppColors.primary)),
        error: (error, stack) => Center(child: Text('Hata: $error')),
      ),
    );
  }
}
