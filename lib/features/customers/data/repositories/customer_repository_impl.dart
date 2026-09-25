import '../../domain/entities/customer_entity.dart';
import '../../domain/repositories/customer_repository.dart';
import '../datasources/customer_remote_data_source.dart';

class CustomerRepositoryImpl implements CustomerRepository {
  final CustomerRemoteDataSource _remoteDataSource;

  CustomerRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<CustomerEntity>> getCustomers(String businessId) async {
    final result = await _remoteDataSource.getCustomers(businessId);
    return result.map((data) => CustomerEntity.fromJson(data, data['id'] as String)).toList();
  }

  @override
  Future<CustomerEntity?> getCustomerById(String customerId) async {
    final data = await _remoteDataSource.getCustomerById(customerId);
    if (data != null) {
      return CustomerEntity.fromJson(data, data['id'] as String);
    }
    return null;
  }

  @override
  Future<void> addCustomer(CustomerEntity customer) async {
    await _remoteDataSource.addCustomer(customer.toJson());
  }

  @override
  Future<void> updateCustomer(CustomerEntity customer) async {
    await _remoteDataSource.updateCustomer(customer.id, customer.toJson());
  }

  @override
  Future<void> deleteCustomer(String customerId) async {
    await _remoteDataSource.deleteCustomer(customerId);
  }
}
