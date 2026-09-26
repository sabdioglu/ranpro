import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../appointments/presentation/providers/appointment_providers.dart';
import '../../../appointments/presentation/widgets/appointment_card.dart';
import '../viewmodels/calendar_view_model.dart';
// Intl paketi tarih formatlama için gereklidir (pubspec.yaml'a eklenmeli)
// import 'package:intl/intl.dart';

class CalendarScreen extends ConsumerWidget {
  const CalendarScreen({super.key});

  Future<void> _selectDate(BuildContext context, WidgetRef ref, DateTime current) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: current,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      ref.read(selectedDateProvider.notifier).state = DateTime(picked.year, picked.month, picked.day);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDate = ref.watch(selectedDateProvider);

    // Seçili günün başlangıcı ve bitişi
    final startOfDay = selectedDate;
    final endOfDay = DateTime(selectedDate.year, selectedDate.month, selectedDate.day, 23, 59, 59);

    final appointmentsAsync = ref.watch(appointmentsByDateRangeProvider({
      'start': startOfDay,
      'end': endOfDay,
    }));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Takvim'),
        actions: [
          IconButton(
            icon: const Icon(Icons.today),
            onPressed: () {
              final now = DateTime.now();
              ref.read(selectedDateProvider.notifier).state = DateTime(now.year, now.month, now.day);
            },
            tooltip: 'Bugün',
          ),
        ],
      ),
      body: Column(
        children: [
          // Tarih Seçici Banner
          Container(
            color: AppColors.surface,
            padding: const EdgeInsets.all(AppDimensions.spacing16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.chevron_left),
                  onPressed: () {
                    ref.read(selectedDateProvider.notifier).state = selectedDate.subtract(const Duration(days: 1));
                  },
                ),
                InkWell(
                  onTap: () => _selectDate(context, ref, selectedDate),
                  child: Text(
                    '${selectedDate.day.toString().padLeft(2, '0')}/${selectedDate.month.toString().padLeft(2, '0')}/${selectedDate.year}',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.chevron_right),
                  onPressed: () {
                    ref.read(selectedDateProvider.notifier).state = selectedDate.add(const Duration(days: 1));
                  },
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          // Randevu Listesi
          Expanded(
            child: appointmentsAsync.when(
              data: (appointments) {
                if (appointments.isEmpty) {
                  return const Center(
                    child: Text('Bu tarihte randevu bulunmuyor.', style: TextStyle(color: AppColors.textSecondary)),
                  );
                }

                return ListView.separated(
                  padding: const EdgeInsets.all(AppDimensions.spacing16),
                  itemCount: appointments.length,
                  separatorBuilder: (_, __) => const SizedBox(height: AppDimensions.spacing8),
                  itemBuilder: (context, index) {
                    final apt = appointments[index];
                    return AppointmentCard(
                      appointment: apt,
                      // TODO: Müşteri ve Hizmet isimleri için CustomerRepository ve ServiceRepository'den veri çekilecek.
                      // Şimdilik mock isimler gösteriyoruz. Stage 16/17'de relational mapping eklenecek.
                      customerName: 'Müşteri (Yükleniyor)',
                      serviceName: 'Hizmet (Yükleniyor)',
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator(color: AppColors.primary)),
              error: (e, _) => Center(child: Text('Hata: $e')),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // GoRouter ile '/create_appointment' sayfasına gidilecek
          // Geçici olarak MaterialPageRoute kullanıyoruz. Router güncellenecek.
          /* Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const CreateAppointmentScreen()),
          ); */
        },
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, color: AppColors.surface),
      ),
    );
  }
}
