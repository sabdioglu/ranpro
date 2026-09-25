import '../../domain/entities/staff_entity.dart';
import '../../domain/repositories/staff_repository.dart';
import '../datasources/staff_remote_data_source.dart';

class StaffRepositoryImpl implements StaffRepository {
  final StaffRemoteDataSource _remoteDataSource;

  StaffRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<StaffEntity>> getStaffList(String businessId) async {
    final result = await _remoteDataSource.getStaffList(businessId);
    return result.map((data) => StaffEntity.fromJson(data, data['id'] as String)).toList();
  }

  @override
  Future<void> addStaff(StaffEntity staff) async {
    await _remoteDataSource.addStaff(staff.toJson());
  }

  @override
  Future<void> updateStaff(StaffEntity staff) async {
    await _remoteDataSource.updateStaff(staff.id, staff.toJson());
  }

  @override
  Future<void> deleteStaff(String staffId) async {
    await _remoteDataSource.deleteStaff(staffId);
  }
}
