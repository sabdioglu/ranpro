import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../authentication/presentation/providers/auth_providers.dart';
import '../../data/datasources/staff_remote_data_source.dart';
import '../../data/repositories/staff_repository_impl.dart';
import '../../domain/repositories/staff_repository.dart';
import '../../domain/entities/staff_entity.dart';
import '../../../business_profile/presentation/providers/business_providers.dart';

final staffRemoteDataSourceProvider = Provider<StaffRemoteDataSource>((ref) {
  final firestore = ref.watch(firebaseFirestoreProvider);
  return StaffRemoteDataSourceImpl(firestore);
});

final staffRepositoryProvider = Provider<StaffRepository>((ref) {
  final dataSource = ref.watch(staffRemoteDataSourceProvider);
  return StaffRepositoryImpl(dataSource);
});

// Oturum açan işletmeye bağlı tüm personelleri getiren provider
final staffListProvider = FutureProvider<List<StaffEntity>>((ref) async {
  final currentBusiness = await ref.watch(currentBusinessProvider.future);
  
  if (currentBusiness == null) {
    return [];
  }

  final repository = ref.watch(staffRepositoryProvider);
  return repository.getStaffList(currentBusiness.id);
});
