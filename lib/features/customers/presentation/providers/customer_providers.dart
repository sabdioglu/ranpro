import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../authentication/presentation/providers/auth_providers.dart';
import '../../data/datasources/customer_remote_data_source.dart';
import '../../data/repositories/customer_repository_impl.dart';
import '../../domain/repositories/customer_repository.dart';
import '../../domain/entities/customer_entity.dart';
import '../../../business_profile/presentation/providers/business_providers.dart';

final customerRemoteDataSourceProvider = Provider<CustomerRemoteDataSource>((ref) {
  final firestore = ref.watch(firebaseFirestoreProvider);
  return CustomerRemoteDataSourceImpl(firestore);
});

final customerRepositoryProvider = Provider<CustomerRepository>((ref) {
  final dataSource = ref.watch(customerRemoteDataSourceProvider);
  return CustomerRepositoryImpl(dataSource);
});

final customersListProvider = FutureProvider<List<CustomerEntity>>((ref) async {
  final currentBusiness = await ref.watch(currentBusinessProvider.future);
  
  if (currentBusiness == null) {
    return [];
  }

  final repository = ref.watch(customerRepositoryProvider);
  return repository.getCustomers(currentBusiness.id);
});
