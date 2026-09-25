import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../providers/staff_providers.dart';
import '../viewmodels/staff_view_model.dart';
import 'add_edit_staff_screen.dart';

class StaffScreen extends ConsumerWidget {
  const StaffScreen({super.key});

  void _navigateToAddEdit(BuildContext context, [dynamic staff]) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AddEditStaffScreen(staffToEdit: staff),
      ),
    );
  }

  void _deleteStaff(BuildContext context, WidgetRef ref, String staffId) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Silme Onayı'),
        content: const Text('Bu personeli silmek istediğinize emin misiniz?'),
        actions: [
          TextButton(onPressed: () => Navigator.of(ctx).pop(), child: const Text('İptal')),
          TextButton(
            onPressed: () {
              ref.read(staffViewModelProvider.notifier).deleteStaff(staffId);
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
    final staffListAsync = ref.watch(staffListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Personeller'),
      ),
      body: staffListAsync.when(
        data: (staffList) {
          if (staffList.isEmpty) {
            return const Center(child: Text('Henüz personel eklenmedi.'));
          }

          return ListView.separated(
            padding: const EdgeInsets.all(AppDimensions.spacing16),
            itemCount: staffList.length,
            separatorBuilder: (_, __) => const SizedBox(height: AppDimensions.spacing8),
            itemBuilder: (context, index) {
              final staff = staffList[index];

              return Card(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: AppColors.primary,
                    child: Text(
                      staff.firstName.isNotEmpty ? staff.firstName[0].toUpperCase() : '?',
                      style: const TextStyle(color: AppColors.surface),
                    ),
                  ),
                  title: Text(staff.fullName, style: const TextStyle(fontWeight: FontWeight.w600)),
                  subtitle: Text(staff.position ?? 'Pozisyon belirtilmemiş'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit_outlined, color: AppColors.info),
                        onPressed: () => _navigateToAddEdit(context, staff),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete_outline, color: AppColors.error),
                        onPressed: () => _deleteStaff(context, ref, staff.id),
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
        onPressed: () => _navigateToAddEdit(context),
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, color: AppColors.surface),
      ),
    );
  }
}
