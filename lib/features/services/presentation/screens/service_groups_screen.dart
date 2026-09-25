import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../providers/service_group_providers.dart';
import '../viewmodels/service_groups_view_model.dart';
import '../dialogs/add_edit_service_group_dialog.dart';

class ServiceGroupsScreen extends ConsumerWidget {
  const ServiceGroupsScreen({super.key});

  void _showAddEditDialog(BuildContext context, [dynamic group]) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AddEditServiceGroupDialog(groupToEdit: group),
    );
  }

  void _deleteGroup(BuildContext context, WidgetRef ref, String groupId) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Silme Onayı'),
        content: const Text('Bu grubu silmek istediğinize emin misiniz? (İçindeki hizmetler silinmez)'),
        actions: [
          TextButton(onPressed: () => Navigator.of(ctx).pop(), child: const Text('İptal')),
          TextButton(
            onPressed: () {
              ref.read(serviceGroupsViewModelProvider.notifier).deleteGroup(groupId);
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
    final serviceGroupsAsync = ref.watch(serviceGroupsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hizmet Grupları'),
      ),
      body: serviceGroupsAsync.when(
        data: (groups) {
          if (groups.isEmpty) {
            return const Center(child: Text('Henüz bir hizmet grubu eklenmedi.'));
          }

          return ListView.separated(
            padding: const EdgeInsets.all(AppDimensions.spacing16),
            itemCount: groups.length,
            separatorBuilder: (_, __) => const SizedBox(height: AppDimensions.spacing8),
            itemBuilder: (context, index) {
              final group = groups[index];

              return Card(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: AppColors.primaryLight.withOpacity(0.2),
                    child: Text(group.order.toString(), style: const TextStyle(color: AppColors.primaryDark)),
                  ),
                  title: Text(group.name, style: const TextStyle(fontWeight: FontWeight.w600)),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit_outlined, color: AppColors.info),
                        onPressed: () => _showAddEditDialog(context, group),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete_outline, color: AppColors.error),
                        onPressed: () => _deleteGroup(context, ref, group.id),
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
