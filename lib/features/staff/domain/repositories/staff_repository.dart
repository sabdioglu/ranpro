import '../entities/staff_entity.dart';

abstract class StaffRepository {
  Future<List<StaffEntity>> getStaffList(String businessId);
  Future<void> addStaff(StaffEntity staff);
  Future<void> updateStaff(StaffEntity staff);
  Future<void> deleteStaff(String staffId);
}
