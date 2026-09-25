import '../entities/business.dart';

abstract class BusinessRepository {
  Future<Business?> getBusinessById(String businessId);
  Future<void> updateBusiness(Business business);
}
