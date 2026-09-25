import 'package:cloud_firestore/cloud_firestore.dart';

abstract class BlockedTimeRemoteDataSource {
  Future<List<Map<String, dynamic>>> getBlockedTimes(String businessId, {String? staffId, DateTime? startDate, DateTime? endDate});
  Future<void> addBlockedTime(Map<String, dynamic> data);
  Future<void> deleteBlockedTime(String id);
}

class BlockedTimeRemoteDataSourceImpl implements BlockedTimeRemoteDataSource {
  final FirebaseFirestore _firestore;

  BlockedTimeRemoteDataSourceImpl(this._firestore);

  @override
  Future<List<Map<String, dynamic>>> getBlockedTimes(String businessId, {String? staffId, DateTime? startDate, DateTime? endDate}) async {
    Query query = _firestore.collection('blockedTimes').where('businessId', isEqualTo: businessId);

    if (staffId != null) {
      query = query.where('staffId', isEqualTo: staffId);
    }

    if (startDate != null) {
      query = query.where('startTime', isGreaterThanOrEqualTo: startDate.toUtc().toIso8601String());
    }

    // Sorgu esnekliğini artırmak için createdAt yerine startTime endeksi kullanılır
    final snapshot = await query.get();

    return snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      data['id'] = doc.id;
      return data;
    }).toList();
  }

  @override
  Future<void> addBlockedTime(Map<String, dynamic> data) async {
    await _firestore.collection('blockedTimes').add(data);
  }

  @override
  Future<void> deleteBlockedTime(String id) async {
    await _firestore.collection('blockedTimes').doc(id).delete();
  }
}
