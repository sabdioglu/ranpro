import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../authentication/presentation/providers/auth_providers.dart';
import '../../data/datasources/business_remote_data_source.dart';
import '../../data/repositories/business_repository_impl.dart';
import '../../domain/repositories/business_repository.dart';
import '../../domain/entities/business.dart';

final businessRemoteDataSourceProvider = Provider<BusinessRemoteDataSource>((ref) {
  final firestore = ref.watch(firebaseFirestoreProvider);
  return BusinessRemoteDataSourceImpl(firestore);
});

final businessRepositoryProvider = Provider<BusinessRepository>((ref) {
  final dataSource = ref.watch(businessRemoteDataSourceProvider);
  return BusinessRepositoryImpl(dataSource);
});

// Oturum açmış kullanıcının bağlı olduğu işletmeyi (tenant) getiren ana provider
final currentBusinessProvider = FutureProvider<Business?>((ref) async {
  final authState = ref.watch(authStateProvider);
  final user = authState.valueOrNull;

  if (user == null || user.businessId == null) {
    return null;
  }

  final repository = ref.watch(businessRepositoryProvider);
  return repository.getBusinessById(user.businessId!);
});
