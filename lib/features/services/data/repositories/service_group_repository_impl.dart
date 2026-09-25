import '../../domain/entities/service_group.dart';
import '../../domain/repositories/service_group_repository.dart';
import '../datasources/service_group_remote_data_source.dart';

class ServiceGroupRepositoryImpl implements ServiceGroupRepository {
  final ServiceGroupRemoteDataSource _remoteDataSource;

  ServiceGroupRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<ServiceGroup>> getServiceGroups(String businessId) async {
    final result = await _remoteDataSource.getServiceGroups(businessId);
    return result.map((data) => ServiceGroup.fromJson(data, data['id'] as String)).toList();
  }

  @override
  Future<void> addServiceGroup(ServiceGroup group) async {
    await _remoteDataSource.addServiceGroup(group.toJson());
  }

  @override
  Future<void> updateServiceGroup(ServiceGroup group) async {
    await _remoteDataSource.updateServiceGroup(group.id, group.toJson());
  }

  @override
  Future<void> deleteServiceGroup(String groupId) async {
    await _remoteDataSource.deleteServiceGroup(groupId);
  }
}
