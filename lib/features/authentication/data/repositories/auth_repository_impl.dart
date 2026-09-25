import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import '../../domain/entities/app_user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';
import '../datasources/user_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;
  final UserRemoteDataSource _userRemoteDataSource;

  AuthRepositoryImpl(
    this._authRemoteDataSource,
    this._userRemoteDataSource,
  );

  Future<AppUser?> _mapFirebaseUser(User? user) async {
    if (user == null) return null;

    final userData = await _userRemoteDataSource.getUserData(user.uid);
    
    return AppUser(
      uid: user.uid,
      email: user.email,
      displayName: user.displayName,
      role: userData?['role'] ?? 'customer',
      businessId: userData?['businessId'],
    );
  }

  @override
  Stream<AppUser?> get authStateChanges {
    // FirebaseAuth state değişimlerini dinler ve Firestore verisiyle birleştirir
    return _authRemoteDataSource.authStateChanges.asyncMap((user) async {
      return await _mapFirebaseUser(user);
    });
  }

  @override
  Future<AppUser?> getCurrentUser() async {
    final user = _authRemoteDataSource.currentUser;
    return await _mapFirebaseUser(user);
  }

  @override
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    await _authRemoteDataSource.signInWithEmailAndPassword(email, password);
  }

  @override
  Future<void> signOut() async {
    await _authRemoteDataSource.signOut();
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    await _authRemoteDataSource.sendPasswordResetEmail(email);
  }
}
