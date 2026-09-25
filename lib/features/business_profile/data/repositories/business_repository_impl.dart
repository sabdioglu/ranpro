import '../../domain/entities/business.dart';
import '../../domain/repositories/business_repository.dart';
import '../datasources/business_remote_data_source.dart';

class BusinessRepositoryImpl implements BusinessRepository {
  final BusinessRemoteDataSource _remoteDataSource;

  BusinessRepositoryImpl(this._remoteDataSource);

  @override
  Future<Business?> getBusinessById(String businessId) async {
    final data = await _remoteDataSource.getBusinessById(businessId);
    if (data != null) {
      return Business.fromJson(data, businessId);
    }
    return null;
  }

  @override
  Future<void> updateBusiness(Business business) async {
    await _remoteDataSource.updateBusiness(business.id, business.toJson());
  }
}
