import '../entities/service_group.dart';

abstract class ServiceGroupRepository {
  Future<List<ServiceGroup>> getServiceGroups(String businessId);
  Future<void> addServiceGroup(ServiceGroup group);
  Future<void> updateServiceGroup(ServiceGroup group);
  Future<void> deleteServiceGroup(String groupId);
}
