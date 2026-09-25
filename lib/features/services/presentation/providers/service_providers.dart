import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../authentication/presentation/providers/auth_providers.dart';
import '../../data/datasources/service_remote_data_source.dart';
import '../../data/repositories/service_repository_impl.dart';
import '../../domain/repositories/service_repository.dart';
import '../../domain/entities/service_entity.dart';
import '../../../business_profile/presentation/providers/business_providers.dart';

final serviceRemoteDataSourceProvider = Provider<ServiceRemoteDataSource>((ref) {
  final firestore = ref.watch(firebaseFirestoreProvider);
  return ServiceRemoteDataSourceImpl(firestore);
});

final serviceRepositoryProvider = Provider<ServiceRepository>((ref) {
  final dataSource = ref.watch(serviceRemoteDataSourceProvider);
  return ServiceRepositoryImpl(dataSource);
});

// Sadece aktif işletmenin hizmetlerini getiren provider
final servicesProvider = FutureProvider<List<ServiceEntity>>((ref) async {
  final currentBusiness = await ref.watch(currentBusinessProvider.future);
  
  if (currentBusiness == null) {
    return [];
  }

  final repository = ref.watch(serviceRepositoryProvider);
  return repository.getServices(currentBusiness.id);
});
