import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../authentication/presentation/providers/auth_providers.dart';
import '../../data/datasources/blocked_time_remote_data_source.dart';
import '../../data/repositories/blocked_time_repository_impl.dart';
import '../../domain/repositories/blocked_time_repository.dart';

final blockedTimeRemoteDataSourceProvider = Provider<BlockedTimeRemoteDataSource>((ref) {
  final firestore = ref.watch(firebaseFirestoreProvider);
  return BlockedTimeRemoteDataSourceImpl(firestore);
});

final blockedTimeRepositoryProvider = Provider<BlockedTimeRepository>((ref) {
  final dataSource = ref.watch(blockedTimeRemoteDataSourceProvider);
  return BlockedTimeRepositoryImpl(dataSource);
});
