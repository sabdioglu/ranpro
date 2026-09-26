import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../domain/entities/appointment_entity.dart';

class AppointmentCard extends StatelessWidget {
  final AppointmentEntity appointment;
  final String customerName; // Gelecekte CustomerProvider üzerinden ID ile isim eşleştirilebilir
  final String serviceName; // Gelecekte ServiceProvider üzerinden ID ile eşleştirilebilir

  const AppointmentCard({
    super.key,
    required this.appointment,
    required this.customerName,
    required this.serviceName,
  });

  Color _getStatusColor() {
    switch (appointment.status) {
      case 'confirmed':
        return AppColors.success;
      case 'cancelled':
        return AppColors.error;
      case 'completed':
        return AppColors.info;
      case 'pending':
      default:
        return AppColors.warning;
    }
  }

  String _getStatusText() {
    switch (appointment.status) {
      case 'confirmed':
        return 'Onaylandı';
      case 'cancelled':
        return 'İptal';
      case 'completed':
        return 'Tamamlandı';
      case 'pending':
      default:
        return 'Bekliyor';
    }
  }

  @override
  Widget build(BuildContext context) {
    final startHour = appointment.startDateTime.hour.toString().padLeft(2, '0');
    final startMin = appointment.startDateTime.minute.toString().padLeft(2, '0');
    final endHour = appointment.endDateTime.hour.toString().padLeft(2, '0');
    final endMin = appointment.endDateTime.minute.toString().padLeft(2, '0');
    
    final formattedPrice = (appointment.price / 100).toStringAsFixed(2);

    return Card(
      child: IntrinsicHeight(
        child: Row(
          children: [
            Container(
              width: 8,
              decoration: BoxDecoration(
                color: _getStatusColor(),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(AppDimensions.radius12),
                  bottomLeft: Radius.circular(AppDimensions.radius12),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(AppDimensions.spacing16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '$startHour:$startMin - $endHour:$endMin',
                          style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: _getStatusColor().withOpacity(0.1),
                            borderRadius: BorderRadius.circular(AppDimensions.radius8),
                          ),
                          child: Text(
                            _getStatusText(),
                            style: TextStyle(color: _getStatusColor(), fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppDimensions.spacing8),
                    Text(
                      customerName,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: AppDimensions.spacing4),
                    Text(
                      serviceName,
                      style: const TextStyle(color: AppColors.textSecondary),
                    ),
                    if (appointment.notes != null && appointment.notes!.isNotEmpty) ...[
                      const SizedBox(height: AppDimensions.spacing8),
                      Row(
                        children: [
                          const Icon(Icons.notes, size: 16, color: AppColors.textSecondary),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              appointment.notes!,
                              style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
