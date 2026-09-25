import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../providers/service_providers.dart';
import '../viewmodels/services_view_model.dart';
import '../dialogs/add_edit_service_dialog.dart';

class ServicesScreen extends ConsumerWidget {
  const ServicesScreen({super.key});

  void _showAddEditDialog(BuildContext context, [dynamic service]) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AddEditServiceDialog(serviceToEdit: service),
    );
  }

  void _deleteService(BuildContext context, WidgetRef ref, String serviceId) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Silme Onayı'),
        content: const Text('Bu hizmeti silmek istediğinize emin misiniz?'),
        actions: [
          TextButton(onPressed: () => Navigator.of(ctx).pop(), child: const Text('İptal')),
          TextButton(
            onPressed: () {
              ref.read(servicesViewModelProvider.notifier).deleteService(serviceId);
              Navigator.of(ctx).pop();
            },
            child: const Text('Sil', style: TextStyle(color: AppColors.error)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final servicesAsync = ref.watch(servicesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hizmetler'),
      ),
      body: servicesAsync.when(
        data: (services) {
          if (services.isEmpty) {
            return const Center(child: Text('Henüz bir hizmet eklenmedi.'));
          }

          return ListView.separated(
            padding: const EdgeInsets.all(AppDimensions.spacing16),
            itemCount: services.length,
            separatorBuilder: (_, __) => const SizedBox(height: AppDimensions.spacing8),
            itemBuilder: (context, index) {
              final service = services[index];
              final formattedPrice = (service.price / 100).toStringAsFixed(2);

              return Card(
                child: ListTile(
                  title: Text(service.name, style: const TextStyle(fontWeight: FontWeight.w600)),
                  subtitle: Text('${service.durationInMinutes} dk - ₺$formattedPrice'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit_outlined, color: AppColors.info),
                        onPressed: () => _showAddEditDialog(context, service),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete_outline, color: AppColors.error),
                        onPressed: () => _deleteService(context, ref, service.id),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator(color: AppColors.primary)),
        error: (error, _) => Center(child: Text('Hata oluştu: $error')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddEditDialog(context),
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, color: AppColors.surface),
      ),
    );
  }
}
