import '../../domain/entities/app_user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;

  AuthRepositoryImpl(this._remoteDataSource);

  AppUser? _mapFirebaseUser(User? user) {
    if (user == null) return null;
    
    // Not: Gerçek rol ve businessId Firestore'dan (users collection) çekilecektir.
    // Bu aşamada JWT token (custom claims) veya varsayılan değer atanır.
    return AppUser(
      uid: user.uid,
      email: user.email,
      displayName: user.displayName,
      role: 'staff', // TODO: Firestore'dan rol çekilecek
      businessId: null, // TODO: Firestore'dan businessId çekilecek
    );
  }

  @override
  Stream<AppUser?> get authStateChanges {
    return _remoteDataSource.authStateChanges.map(_mapFirebaseUser);
  }

  @override
  Future<AppUser?> getCurrentUser() async {
    final user = _remoteDataSource.currentUser;
    return _mapFirebaseUser(user);
  }

  @override
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    await _remoteDataSource.signInWithEmailAndPassword(email, password);
  }

  @override
  Future<void> signOut() async {
    await _remoteDataSource.signOut();
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    await _remoteDataSource.sendPasswordResetEmail(email);
  }
}
