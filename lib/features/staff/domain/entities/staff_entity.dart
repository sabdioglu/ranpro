class StaffEntity {
  final String id;
  final String businessId;
  final String firstName;
  final String lastName;
  final String? photoUrl;
  final String? phone;
  final String? email;
  final String? position;
  final List<String> serviceIds;
  final bool isActive;

  const StaffEntity({
    required this.id,
    required this.businessId,
    required this.firstName,
    required this.lastName,
    this.photoUrl,
    this.phone,
    this.email,
    this.position,
    this.serviceIds = const [],
    this.isActive = true,
  });

  String get fullName => '$firstName $lastName';

  factory StaffEntity.fromJson(Map<String, dynamic> json, String id) {
    return StaffEntity(
      id: id,
      businessId: json['businessId'] as String? ?? '',
      firstName: json['firstName'] as String? ?? '',
      lastName: json['lastName'] as String? ?? '',
      photoUrl: json['photoUrl'] as String?,
      phone: json['phone'] as String?,
      email: json['email'] as String?,
      position: json['position'] as String?,
      serviceIds: List<String>.from(json['serviceIds'] ?? []),
      isActive: json['isActive'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'businessId': businessId,
      'firstName': firstName,
      'lastName': lastName,
      'photoUrl': photoUrl,
      'phone': phone,
      'email': email,
      'position': position,
      'serviceIds': serviceIds,
      'isActive': isActive,
    };
  }
}
