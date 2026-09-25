import 'package:cloud_firestore/cloud_firestore.dart';

abstract class CustomerRemoteDataSource {
  Future<List<Map<String, dynamic>>> getCustomers(String businessId);
  Future<Map<String, dynamic>?> getCustomerById(String customerId);
  Future<void> addCustomer(Map<String, dynamic> data);
  Future<void> updateCustomer(String customerId, Map<String, dynamic> data);
  Future<void> deleteCustomer(String customerId);
}

class CustomerRemoteDataSourceImpl implements CustomerRemoteDataSource {
  final FirebaseFirestore _firestore;

  CustomerRemoteDataSourceImpl(this._firestore);

  @override
  Future<List<Map<String, dynamic>>> getCustomers(String businessId) async {
    final snapshot = await _firestore
        .collection('customers')
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
  Future<Map<String, dynamic>?> getCustomerById(String customerId) async {
    final doc = await _firestore.collection('customers').doc(customerId).get();
    if (doc.exists) {
      final data = doc.data()!;
      data['id'] = doc.id;
      return data;
    }
    return null;
  }

  @override
  Future<void> addCustomer(Map<String, dynamic> data) async {
    await _firestore.collection('customers').add(data);
  }

  @override
  Future<void> updateCustomer(String customerId, Map<String, dynamic> data) async {
    await _firestore.collection('customers').doc(customerId).update(data);
  }

  @override
  Future<void> deleteCustomer(String customerId) async {
    await _firestore.collection('customers').doc(customerId).delete();
  }
}
