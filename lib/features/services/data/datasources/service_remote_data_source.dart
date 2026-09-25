import 'package:cloud_firestore/cloud_firestore.dart';

abstract class ServiceRemoteDataSource {
  Future<List<Map<String, dynamic>>> getServices(String businessId);
  Future<void> addService(Map<String, dynamic> data);
  Future<void> updateService(String serviceId, Map<String, dynamic> data);
  Future<void> deleteService(String serviceId);
}

class ServiceRemoteDataSourceImpl implements ServiceRemoteDataSource {
  final FirebaseFirestore _firestore;

  ServiceRemoteDataSourceImpl(this._firestore);

  @override
  Future<List<Map<String, dynamic>>> getServices(String businessId) async {
    final snapshot = await _firestore
        .collection('services')
        .where('businessId', isEqualTo: businessId)
        .orderBy('name')
        .get();

    return snapshot.docs.map((doc) {
      final data = doc.data();
      data['id'] = doc.id; // Model çevrimi için ID'yi map içine ekliyoruz
      return data;
    }).toList();
  }

  @override
  Future<void> addService(Map<String, dynamic> data) async {
    await _firestore.collection('services').add(data);
  }

  @override
  Future<void> updateService(String serviceId, Map<String, dynamic> data) async {
    await _firestore.collection('services').doc(serviceId).update(data);
  }

  @override
  Future<void> deleteService(String serviceId) async {
    // Körü körüne silmek yerine soft delete de uygulanabilir. (Şu an hard delete)
    await _firestore.collection('services').doc(serviceId).delete();
  }
}
