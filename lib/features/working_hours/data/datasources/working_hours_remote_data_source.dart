import 'package:cloud_firestore/cloud_firestore.dart';

abstract class WorkingHoursRemoteDataSource {
  Future<List<Map<String, dynamic>>> getBusinessWorkingHours(String businessId);
  Future<List<Map<String, dynamic>>> getStaffWorkingHours(String businessId, String staffId);
  Future<void> updateWorkingHour(String docId, Map<String, dynamic> data);
  Future<void> batchUpdateWorkingHours(List<Map<String, dynamic>> dataList);
}

class WorkingHoursRemoteDataSourceImpl implements WorkingHoursRemoteDataSource {
  final FirebaseFirestore _firestore;

  WorkingHoursRemoteDataSourceImpl(this._firestore);

  @override
  Future<List<Map<String, dynamic>>> getBusinessWorkingHours(String businessId) async {
    final snapshot = await _firestore
        .collection('workingHours')
        .where('businessId', isEqualTo: businessId)
        .where('staffId', isNull: true)
        .orderBy('dayOfWeek')
        .get();

    return snapshot.docs.map((doc) {
      final data = doc.data();
      data['id'] = doc.id;
      return data;
    }).toList();
  }

  @override
  Future<List<Map<String, dynamic>>> getStaffWorkingHours(String businessId, String staffId) async {
    final snapshot = await _firestore
        .collection('workingHours')
        .where('businessId', isEqualTo: businessId)
        .where('staffId', isEqualTo: staffId)
        .orderBy('dayOfWeek')
        .get();

    return snapshot.docs.map((doc) {
      final data = doc.data();
      data['id'] = doc.id;
      return data;
    }).toList();
  }

  @override
  Future<void> updateWorkingHour(String docId, Map<String, dynamic> data) async {
    await _firestore.collection('workingHours').doc(docId).set(data, SetOptions(merge: true));
  }

  @override
  Future<void> batchUpdateWorkingHours(List<Map<String, dynamic>> dataList) async {
    final batch = _firestore.batch();
    
    for (var data in dataList) {
      final docId = data['id'] as String;
      // İd alanını firestore verisinden çıkarıyoruz
      final payload = Map<String, dynamic>.from(data)..remove('id');
      
      final docRef = docId.isEmpty 
          ? _firestore.collection('workingHours').doc() 
          : _firestore.collection('workingHours').doc(docId);
          
      batch.set(docRef, payload, SetOptions(merge: true));
    }
    
    await batch.commit();
  }
}
