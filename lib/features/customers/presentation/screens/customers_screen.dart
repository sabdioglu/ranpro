import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../providers/customer_providers.dart';
import '../viewmodels/customers_view_model.dart';
import 'add_edit_customer_screen.dart';

class CustomersScreen extends ConsumerWidget {
  const CustomersScreen({super.key});

  void _navigateToAddEdit(BuildContext context, [dynamic customer]) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AddEditCustomerScreen(customerToEdit: customer),
      ),
    );
  }

  void _deleteCustomer(BuildContext context, WidgetRef ref, String customerId) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Silme Onayı'),
        content: const Text('Bu müşteriyi silmek istediğinize emin misiniz? (Randevu geçmişleri etkilenebilir)'),
        actions: [
          TextButton(onPressed: () => Navigator.of(ctx).pop(), child: const Text('İptal')),
          TextButton(
            onPressed: () {
              ref.read(customersViewModelProvider.notifier).deleteCustomer(customerId);
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
    final customersAsync = ref.watch(customersListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Müşteriler'),
      ),
      body: customersAsync.when(
        data: (customers) {
          if (customers.isEmpty) {
            return const Center(child: Text('Henüz müşteri eklenmedi.'));
          }

          return ListView.separated(
            padding: const EdgeInsets.all(AppDimensions.spacing16),
            itemCount: customers.length,
            separatorBuilder: (_, __) => const SizedBox(height: AppDimensions.spacing8),
            itemBuilder: (context, index) {
              final customer = customers[index];
              final formattedSpent = (customer.totalSpent / 100).toStringAsFixed(2);

              return Card(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: AppColors.primaryLight.withOpacity(0.2),
                    child: Text(
                      customer.firstName.isNotEmpty ? customer.firstName[0].toUpperCase() : '?',
                      style: const TextStyle(color: AppColors.primaryDark, fontWeight: FontWeight.bold),
                    ),
                  ),
                  title: Text(customer.fullName, style: const TextStyle(fontWeight: FontWeight.w600)),
                  subtitle: Text(customer.phone),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('${customer.totalVisits} Ziyaret', style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                          Text('₺$formattedSpent', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.success)),
                        ],
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        icon: const Icon(Icons.edit_outlined, color: AppColors.info),
                        onPressed: () => _navigateToAddEdit(context, customer),
                      ),
                    ],
                  ),
                  onTap: () {
                    // İleride Detay Ekranına (Customer Detail / History) gidecek.
                    // Şimdilik düzenleme ekranına yönlendiriyoruz.
                    _navigateToAddEdit(context, customer);
                  },
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
