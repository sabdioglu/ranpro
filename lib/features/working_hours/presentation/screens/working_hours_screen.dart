import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../business_profile/presentation/providers/business_providers.dart';
import '../../domain/entities/working_hours_entity.dart';
import '../providers/working_hours_providers.dart';
import '../viewmodels/working_hours_view_model.dart';

class WorkingHoursScreen extends ConsumerStatefulWidget {
  final String? staffId; // Eğer null ise işletme çalışma saati, değilse personel.

  const WorkingHoursScreen({super.key, this.staffId});

  @override
  ConsumerState<WorkingHoursScreen> createState() => _WorkingHoursScreenState();
}

class _WorkingHoursScreenState extends ConsumerState<WorkingHoursScreen> {
  List<WorkingHoursEntity>? _editableHours;

  final List<String> _dayNames = [
    'Pazartesi', 'Salı', 'Çarşamba', 'Perşembe', 'Cuma', 'Cumartesi', 'Pazar'
  ];

  void _initializeHours(List<WorkingHoursEntity> data, String businessId) {
    if (_editableHours != null) return;
    
    _editableHours = List.generate(7, (index) {
      final dayOfWeek = index + 1;
      final existing = data.where((e) => e.dayOfWeek == dayOfWeek).toList();
      
      if (existing.isNotEmpty) {
        return existing.first;
      } else {
        // Varsayılan boş saat oluştur
        return WorkingHoursEntity(
          id: '',
          businessId: businessId,
          staffId: widget.staffId,
          dayOfWeek: dayOfWeek,
          startTime: '09:00',
          endTime: '18:00',
          isClosed: dayOfWeek == 7, // Pazar varsayılan kapalı
        );
      }
    });
  }

  Future<void> _pickTime(BuildContext context, int index, bool isStart) async {
    final currentEntity = _editableHours![index];
    final currentTimeString = isStart ? currentEntity.startTime : currentEntity.endTime;
    
    final parts = currentTimeString.split(':');
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
      final newTimeString = '${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}';
      setState(() {
        _editableHours![index] = WorkingHoursEntity(
          id: currentEntity.id,
          businessId: currentEntity.businessId,
          staffId: currentEntity.staffId,
          dayOfWeek: currentEntity.dayOfWeek,
          startTime: isStart ? newTimeString : currentEntity.startTime,
          endTime: isStart ? currentEntity.endTime : newTimeString,
          isClosed: currentEntity.isClosed,
        );
      });
    }
  }

  void _toggleClosed(int index, bool value) {
    setState(() {
      final current = _editableHours![index];
      _editableHours![index] = WorkingHoursEntity(
        id: current.id,
        businessId: current.businessId,
        staffId: current.staffId,
        dayOfWeek: current.dayOfWeek,
        startTime: current.startTime,
        endTime: current.endTime,
        isClosed: value,
      );
    });
  }

  Future<void> _save() async {
    if (_editableHours == null) return;
    await ref.read(workingHoursViewModelProvider.notifier).saveWorkingHours(
          _editableHours!,
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
    final asyncHours = widget.staffId == null
        ? ref.watch(businessWorkingHoursProvider)
        : ref.watch(staffWorkingHoursProvider(widget.staffId!));
        
    final currentBusiness = ref.watch(currentBusinessProvider).valueOrNull;
    final viewModelState = ref.watch(workingHoursViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.staffId == null ? 'İşletme Çalışma Saatleri' : 'Personel Çalışma Saatleri'),
      ),
      body: currentBusiness == null
          ? const Center(child: CircularProgressIndicator())
          : asyncHours.when(
              data: (data) {
                _initializeHours(data, currentBusiness.id);

                return Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        padding: const EdgeInsets.all(AppDimensions.spacing16),
                        itemCount: 7,
                        separatorBuilder: (_, __) => const SizedBox(height: AppDimensions.spacing8),
                        itemBuilder: (context, index) {
                          final dayData = _editableHours![index];
                          final isClosed = dayData.isClosed;

                          return Card(
                            child: Padding(
                              padding: const EdgeInsets.all(AppDimensions.spacing12),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 90,
                                    child: Text(
                                      _dayNames[index],
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: isClosed ? AppColors.textSecondary : AppColors.textPrimary,
                                        decoration: isClosed ? TextDecoration.lineThrough : null,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        if (!isClosed) ...[
                                          InkWell(
                                            onTap: () => _pickTime(context, index, true),
                                            child: Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                              decoration: BoxDecoration(
                                                border: Border.all(color: AppColors.border),
                                                borderRadius: BorderRadius.circular(AppDimensions.radius8),
                                              ),
                                              child: Text(dayData.startTime),
                                            ),
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                                            child: Text('-'),
                                          ),
                                          InkWell(
                                            onTap: () => _pickTime(context, index, false),
                                            child: Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                              decoration: BoxDecoration(
                                                border: Border.all(color: AppColors.border),
                                                borderRadius: BorderRadius.circular(AppDimensions.radius8),
                                              ),
                                              child: Text(dayData.endTime),
                                            ),
                                          ),
                                        ] else ...[
                                          const Text('Kapalı', style: TextStyle(color: AppColors.error, fontWeight: FontWeight.bold)),
                                        ],
                                      ],
                                    ),
                                  ),
                                  Switch(
                                    value: !isClosed,
                                    activeColor: AppColors.success,
                                    onChanged: (val) => _toggleClosed(index, !val),
                                  ),
                                ],
                              ),
                            ),
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
              loading: () => const Center(child: CircularProgressIndicator(color: AppColors.primary)),
              error: (error, _) => Center(child: Text('Hata: $error')),
            ),
    );
  }
}
