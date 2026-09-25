import '../entities/working_hours_entity.dart';

abstract class WorkingHoursRepository {
  Future<List<WorkingHoursEntity>> getBusinessWorkingHours(String businessId);
  Future<List<WorkingHoursEntity>> getStaffWorkingHours(String businessId, String staffId);
  Future<void> updateWorkingHour(WorkingHoursEntity workingHour);
  Future<void> batchUpdateWorkingHours(List<WorkingHoursEntity> workingHours); // Toplu güncelleme için
}
