import 'package:cloud_firestore/cloud_firestore.dart';

abstract class ServiceGroupRemoteDataSource {
  Future<List<Map<String, dynamic>>> getServiceGroups(String businessId);
  Future<void> addServiceGroup(Map<String, dynamic> data);
  Future<void> updateServiceGroup(String groupId, Map<String, dynamic> data);
  Future<void> deleteServiceGroup(String groupId);
}

class ServiceGroupRemoteDataSourceImpl implements ServiceGroupRemoteDataSource {
  final FirebaseFirestore _firestore;

  ServiceGroupRemoteDataSourceImpl(this._firestore);

  @override
  Future<List<Map<String, dynamic>>> getServiceGroups(String businessId) async {
    final snapshot = await _firestore
        .collection('serviceGroups')
        .where('businessId', isEqualTo: businessId)
        .orderBy('order')
        .get();

    return snapshot.docs.map((doc) {
      final data = doc.data();
      data['id'] = doc.id;
      return data;
    }).toList();
  }

  @override
  Future<void> addServiceGroup(Map<String, dynamic> data) async {
    await _firestore.collection('serviceGroups').add(data);
  }

  @override
  Future<void> updateServiceGroup(String groupId, Map<String, dynamic> data) async {
    await _firestore.collection('serviceGroups').doc(groupId).update(data);
  }

  @override
  Future<void> deleteServiceGroup(String groupId) async {
    await _firestore.collection('serviceGroups').doc(groupId).delete();
  }
}
