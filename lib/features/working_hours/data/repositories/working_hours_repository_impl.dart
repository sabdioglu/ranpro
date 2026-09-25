import '../../domain/entities/working_hours_entity.dart';
import '../../domain/repositories/working_hours_repository.dart';
import '../datasources/working_hours_remote_data_source.dart';

class WorkingHoursRepositoryImpl implements WorkingHoursRepository {
  final WorkingHoursRemoteDataSource _remoteDataSource;

  WorkingHoursRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<WorkingHoursEntity>> getBusinessWorkingHours(String businessId) async {
    final result = await _remoteDataSource.getBusinessWorkingHours(businessId);
    return result.map((data) => WorkingHoursEntity.fromJson(data, data['id'] as String)).toList();
  }

  @override
  Future<List<WorkingHoursEntity>> getStaffWorkingHours(String businessId, String staffId) async {
    final result = await _remoteDataSource.getStaffWorkingHours(businessId, staffId);
    return result.map((data) => WorkingHoursEntity.fromJson(data, data['id'] as String)).toList();
  }

  @override
  Future<void> updateWorkingHour(WorkingHoursEntity workingHour) async {
    await _remoteDataSource.updateWorkingHour(workingHour.id, workingHour.toJson());
  }

  @override
  Future<void> batchUpdateWorkingHours(List<WorkingHoursEntity> workingHours) async {
    final mappedList = workingHours.map((e) {
      final json = e.toJson();
      json['id'] = e.id;
      return json;
    }).toList();
    
    await _remoteDataSource.batchUpdateWorkingHours(mappedList);
  }
}
