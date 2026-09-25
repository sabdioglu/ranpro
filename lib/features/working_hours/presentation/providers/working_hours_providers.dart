import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../authentication/presentation/providers/auth_providers.dart';
import '../../data/datasources/working_hours_remote_data_source.dart';
import '../../data/repositories/working_hours_repository_impl.dart';
import '../../domain/repositories/working_hours_repository.dart';
import '../../domain/entities/working_hours_entity.dart';
import '../../../business_profile/presentation/providers/business_providers.dart';

final workingHoursRemoteDataSourceProvider = Provider<WorkingHoursRemoteDataSource>((ref) {
  final firestore = ref.watch(firebaseFirestoreProvider);
  return WorkingHoursRemoteDataSourceImpl(firestore);
});

final workingHoursRepositoryProvider = Provider<WorkingHoursRepository>((ref) {
  final dataSource = ref.watch(workingHoursRemoteDataSourceProvider);
  return WorkingHoursRepositoryImpl(dataSource);
});

// İşletmenin genel çalışma saatlerini çeken provider
final businessWorkingHoursProvider = FutureProvider<List<WorkingHoursEntity>>((ref) async {
  final currentBusiness = await ref.watch(currentBusinessProvider.future);
  if (currentBusiness == null) return [];

  final repository = ref.watch(workingHoursRepositoryProvider);
  return repository.getBusinessWorkingHours(currentBusiness.id);
});

// Belirli bir personelin çalışma saatlerini çeken provider (Family kullanıldı çünkü parametre alıyor)
final staffWorkingHoursProvider = FutureProvider.family<List<WorkingHoursEntity>, String>((ref, staffId) async {
  final currentBusiness = await ref.watch(currentBusinessProvider.future);
  if (currentBusiness == null) return [];

  final repository = ref.watch(workingHoursRepositoryProvider);
  return repository.getStaffWorkingHours(currentBusiness.id, staffId);
});
