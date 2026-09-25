import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../business_profile/presentation/providers/business_providers.dart';
import '../../domain/entities/working_hours_entity.dart';
import '../providers/working_hours_providers.dart';
import '../viewmodels/working_hours_view_model.dart';

class WorkingHoursScreen extends ConsumerStatefulWidget {
  final String? staffId; // null ise İşletme çalışma saatleri düzenlenir
  final String? staffName; // Başlıkta göstermek için

  const WorkingHoursScreen({super.key, this.staffId, this.staffName});

  @override
  ConsumerState<WorkingHoursScreen> createState() => _WorkingHoursScreenState();
}

class _WorkingHoursScreenState extends ConsumerState<WorkingHoursScreen> {
  List<WorkingHoursEntity> _currentHours = [];
  bool _isInitialized = false;

  final List<String> _days = [
    'Pazartesi', 'Salı', 'Çarşamba', 'Perşembe', 'Cuma', 'Cumartesi', 'Pazar'
  ];

  void _initHours(List<WorkingHoursEntity> fetchedHours, String businessId) {
    if (_isInitialized) return;
    
    List<WorkingHoursEntity> tempList = [];
    for (int i = 1; i <= 7; i++) {
      // O güne ait kayıt var mı bul, yoksa default (09:00 - 18:00) oluştur
      final existing = fetchedHours.where((e) => e.dayOfWeek == i).toList();
      if (existing.isNotEmpty) {
        tempList.add(existing.first);
      } else {
        tempList.add(
          WorkingHoursEntity(
            id: '',
            businessId: businessId,
            staffId: widget.staffId,
            dayOfWeek: i,
            startTime: '09:00',
            endTime: '18:00',
            isClosed: i == 7, // Default Pazar kapalı
          ),
        );
      }
    }
    
    // Future build sonrasında state'i güvenle set etmek için microtask
    Future.microtask(() {
      setState(() {
        _currentHours = tempList;
        _isInitialized = true;
      });
    });
  }

  Future<void> _selectTime(BuildContext context, int index, bool isStartTime) async {
    final currentStr = isStartTime ? _currentHours[index].startTime : _currentHours[index].endTime;
    final parts = currentStr.split(':');
    final initialTime = TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));

    final picked = await showTimePicker(
      context: context,
      initialTime: initialTime,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );

    if (picked != null) {
      final formattedTime = '${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}';
      setState(() {
        final old = _currentHours[index];
        _currentHours[index] = WorkingHoursEntity(
          id: old.id,
          businessId: old.businessId,
          staffId: old.staffId,
          dayOfWeek: old.dayOfWeek,
          startTime: isStartTime ? formattedTime : old.startTime,
          endTime: !isStartTime ? formattedTime : old.endTime,
          isClosed: old.isClosed,
        );
      });
    }
  }

  void _toggleClosed(int index, bool value) {
    setState(() {
      final old = _currentHours[index];
      _currentHours[index] = WorkingHoursEntity(
        id: old.id,
        businessId: old.businessId,
        staffId: old.staffId,
        dayOfWeek: old.dayOfWeek,
        startTime: old.startTime,
        endTime: old.endTime,
        isClosed: value,
      );
    });
  }

  Future<void> _save() async {
    if (_currentHours.isEmpty) return;
    await ref.read(workingHoursViewModelProvider.notifier).saveWorkingHours(
      _currentHours,
      staffId: widget.staffId,
    );
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Çalışma saatleri kaydedildi.'), backgroundColor: AppColors.success),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final title = widget.staffId == null 
        ? 'İşletme Çalışma Saatleri' 
        : '${widget.staffName ?? "Personel"} Çalışma Saatleri';

    final asyncHours = widget.staffId == null
        ? ref.watch(businessWorkingHoursProvider)
        : ref.watch(staffWorkingHoursProvider(widget.staffId!));

    final currentBusinessAsync = ref.watch(currentBusinessProvider);
    final viewModelState = ref.watch(workingHoursViewModelProvider);

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: currentBusinessAsync.when(
        data: (business) {
          if (business == null) return const Center(child: Text('İşletme bulunamadı.'));

          return asyncHours.when(
            data: (hours) {
              _initHours(hours, business.id);

              if (!_isInitialized) {
                return const Center(child: CircularProgressIndicator());
              }

              return Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      padding: const EdgeInsets.all(AppDimensions.spacing16),
                      itemCount: _currentHours.length,
                      separatorBuilder: (_, __) => const Divider(),
                      itemBuilder: (context, index) {
                        final item = _currentHours[index];
                        final dayName = _days[index];

                        return Row(
                          children: [
                            SizedBox(
                              width: 100,
                              child: Text(
                                dayName, 
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: item.isClosed ? AppColors.textSecondary : AppColors.textPrimary,
                                  decoration: item.isClosed ? TextDecoration.lineThrough : null,
                                ),
                              ),
                            ),
                            Switch(
                              value: !item.isClosed,
                              activeColor: AppColors.primary,
                              onChanged: (val) => _toggleClosed(index, !val),
                            ),
                            const Spacer(),
                            if (!item.isClosed) ...[
                              InkWell(
                                onTap: () => _selectTime(context, index, true),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: AppColors.border),
                                    borderRadius: BorderRadius.circular(AppDimensions.radius8),
                                  ),
                                  child: Text(item.startTime),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text('-'),
                              ),
                              InkWell(
                                onTap: () => _selectTime(context, index, false),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: AppColors.border),
                                    borderRadius: BorderRadius.circular(AppDimensions.radius8),
                                  ),
                                  child: Text(item.endTime),
                                ),
                              ),
                            ] else ...[
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 8.0),
                                child: Text('Kapalı / İzinli', style: TextStyle(color: AppColors.error)),
                              ),
                            ]
                          ],
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(AppDimensions.spacing16),
                    child: ElevatedButton(
                      onPressed: viewModelState.isLoading ? null : _save,
                      child: viewModelState.isLoading
                          ? const SizedBox(height: 24, width: 24, child: CircularProgressIndicator(color: AppColors.surface, strokeWidth: 2))
                          : const Text('Kaydet'),
                    ),
                  ),
                ],
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(child: Text('Hata: $e')),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Hata: $e')),
      ),
    );
  }
}
