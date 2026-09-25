import '../entities/customer_entity.dart';

abstract class CustomerRepository {
  Future<List<CustomerEntity>> getCustomers(String businessId);
  Future<CustomerEntity?> getCustomerById(String customerId);
  Future<void> addCustomer(CustomerEntity customer);
  Future<void> updateCustomer(CustomerEntity customer);
  Future<void> deleteCustomer(String customerId);
}
