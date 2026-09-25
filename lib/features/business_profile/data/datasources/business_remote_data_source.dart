import 'package:cloud_firestore/cloud_firestore.dart';

abstract class BusinessRemoteDataSource {
  Future<Map<String, dynamic>?> getBusinessById(String businessId);
  Future<void> updateBusiness(String businessId, Map<String, dynamic> data);
}

class BusinessRemoteDataSourceImpl implements BusinessRemoteDataSource {
  final FirebaseFirestore _firestore;

  BusinessRemoteDataSourceImpl(this._firestore);

  @override
  Future<Map<String, dynamic>?> getBusinessById(String businessId) async {
    final doc = await _firestore.collection('businesses').doc(businessId).get();
    if (doc.exists) {
      return doc.data();
    }
    return null;
  }

  @override
  Future<void> updateBusiness(String businessId, Map<String, dynamic> data) async {
    await _firestore.collection('businesses').doc(businessId).update(data);
  }
}