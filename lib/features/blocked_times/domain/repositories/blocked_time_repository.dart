import '../entities/blocked_time_entity.dart';

abstract class BlockedTimeRepository {
  Future<List<BlockedTimeEntity>> getBlockedTimes(String businessId, {String? staffId, DateTime? startDate, DateTime? endDate});
  Future<void> addBlockedTime(BlockedTimeEntity blockedTime);
  Future<void> updateBlockedTime(BlockedTimeEntity blockedTime);
  Future<void> deleteBlockedTime(String blockedTimeId);
}
