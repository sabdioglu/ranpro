import 'package:cloud_firestore/cloud_firestore.dart';

abstract class StaffRemoteDataSource {
  Future<List<Map<String, dynamic>>> getStaffList(String businessId);
  Future<void> addStaff(Map<String, dynamic> data);
  Future<void> updateStaff(String staffId, Map<String, dynamic> data);
  Future<void> deleteStaff(String staffId);
}

class StaffRemoteDataSourceImpl implements StaffRemoteDataSource {
  final FirebaseFirestore _firestore;

  StaffRemoteDataSourceImpl(this._firestore);

  @override
  Future<List<Map<String, dynamic>>> getStaffList(String businessId) async {
    final snapshot = await _firestore
        .collection('staff')
        .where('businessId', isEqualTo: businessId)
        .orderBy('firstName')
        .get();

    return snapshot.docs.map((doc) {
      final data = doc.data();
      data['id'] = doc.id;
      return data;
    }).toList();
  }

  @override
  Future<void> addStaff(Map<String, dynamic> data) async {
    await _firestore.collection('staff').add(data);
  }

  @override
  Future<void> updateStaff(String staffId, Map<String, dynamic> data) async {
    await _firestore.collection('staff').doc(staffId).update(data);
  }

  @override
  Future<void> deleteStaff(String staffId) async {
    await _firestore.collection('staff').doc(staffId).delete();
  }
}
