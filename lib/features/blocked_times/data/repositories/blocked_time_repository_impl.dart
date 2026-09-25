import '../../domain/entities/blocked_time_entity.dart';
import '../../domain/repositories/blocked_time_repository.dart';
import '../datasources/blocked_time_remote_data_source.dart';

class BlockedTimeRepositoryImpl implements BlockedTimeRepository {
  final BlockedTimeRemoteDataSource _remoteDataSource;

  BlockedTimeRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<BlockedTimeEntity>> getBlockedTimes(
    String businessId, {
    String? staffId,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final result = await _remoteDataSource.getBlockedTimes(
      businessId, 
      staffId: staffId, 
      startDate: startDate, 
      endDate: endDate,
    );
    
    return result.map((data) => BlockedTimeEntity.fromJson(data, data['id'] as String)).toList();
  }

  @override
  Future<void> addBlockedTime(BlockedTimeEntity blockedTime) async {
    await _remoteDataSource.addBlockedTime(blockedTime.toJson());
  }

  @override
  Future<void> updateBlockedTime(BlockedTimeEntity blockedTime) async {
    await _remoteDataSource.updateBlockedTime(blockedTime.id, blockedTime.toJson());
  }

  @override
  Future<void> deleteBlockedTime(String blockedTimeId) async {
    await _remoteDataSource.deleteBlockedTime(blockedTimeId);
  }
}
