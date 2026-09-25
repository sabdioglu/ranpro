import 'package:cloud_firestore/cloud_firestore.dart';

abstract class BlockedTimeRemoteDataSource {
  Future<List<Map<String, dynamic>>> getBlockedTimes(String businessId, {String? staffId, DateTime? startDate, DateTime? endDate});
  Future<void> addBlockedTime(Map<String, dynamic> data);
  Future<void> updateBlockedTime(String docId, Map<String, dynamic> data);
  Future<void> deleteBlockedTime(String docId);
}

class BlockedTimeRemoteDataSourceImpl implements BlockedTimeRemoteDataSource {
  final FirebaseFirestore _firestore;

  BlockedTimeRemoteDataSourceImpl(this._firestore);

  @override
  Future<List<Map<String, dynamic>>> getBlockedTimes(
    String businessId, {
    String? staffId,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    Query query = _firestore.collection('blockedTimes')
        .where('businessId', isEqualTo: businessId);
        
    if (staffId != null) {
      query = query.where('staffId', isEqualTo: staffId);
    }
    
    // Not: Gerçek senaryoda startDateTime ve endDateTime üzerinden where filtrelemesi yapılabilir, 
    // ancak Firestore string tarihler için startAt/endAt kullanmayı gerektirir. 
    // Basitlik ve esneklik açısından memory'de filtrelemek veya composite index kurgulamak gerekir.
    // Şimdilik business/staff altındaki kayıtları çekiyoruz.

    final snapshot = await query.get();

    final results = snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      data['id'] = doc.id;
      return data;
    }).toList();
    
    // Client-side date filtering (String ISO8601 karşılaştırması üzerinden)
    if (startDate != null && endDate != null) {
      return results.where((item) {
        final itemStart = DateTime.parse(item['startDateTime'].toString());
        return itemStart.isAfter(startDate.subtract(const Duration(days: 1))) && 
               itemStart.isBefore(endDate.add(const Duration(days: 1)));
      }).toList();
    }

    return results;
  }

  @override
  Future<void> addBlockedTime(Map<String, dynamic> data) async {
    await _firestore.collection('blockedTimes').add(data);
  }

  @override
  Future<void> updateBlockedTime(String docId, Map<String, dynamic> data) async {
    await _firestore.collection('blockedTimes').doc(docId).update(data);
  }

  @override
  Future<void> deleteBlockedTime(String docId) async {
    await _firestore.collection('blockedTimes').doc(docId).delete();
  }
}
