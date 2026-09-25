import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../authentication/presentation/providers/auth_providers.dart';
import '../../data/datasources/service_group_remote_data_source.dart';
import '../../data/repositories/service_group_repository_impl.dart';
import '../../domain/repositories/service_group_repository.dart';
import '../../domain/entities/service_group.dart';
import '../../../business_profile/presentation/providers/business_providers.dart';

final serviceGroupRemoteDataSourceProvider = Provider<ServiceGroupRemoteDataSource>((ref) {
  final firestore = ref.watch(firebaseFirestoreProvider);
  return ServiceGroupRemoteDataSourceImpl(firestore);
});

final serviceGroupRepositoryProvider = Provider<ServiceGroupRepository>((ref) {
  final dataSource = ref.watch(serviceGroupRemoteDataSourceProvider);
  return ServiceGroupRepositoryImpl(dataSource);
});

final serviceGroupsProvider = FutureProvider<List<ServiceGroup>>((ref) async {
  final currentBusiness = await ref.watch(currentBusinessProvider.future);
  
  if (currentBusiness == null) {
    return [];
  }

  final repository = ref.watch(serviceGroupRepositoryProvider);
  return repository.getServiceGroups(currentBusiness.id);
});
