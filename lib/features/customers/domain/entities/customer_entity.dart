class CustomerEntity {
  final String id;
  final String businessId;
  final String firstName;
  final String lastName;
  final String phone;
  final String? email;
  final String? notes;
  final int totalVisits;
  final int totalSpent; // Kuruş cinsinden
  final DateTime createdAt;
  final DateTime? lastVisitAt;
  final bool isActive;

  const CustomerEntity({
    required this.id,
    required this.businessId,
    required this.firstName,
    required this.lastName,
    required this.phone,
    this.email,
    this.notes,
    this.totalVisits = 0,
    this.totalSpent = 0,
    required this.createdAt,
    this.lastVisitAt,
    this.isActive = true,
  });

  String get fullName => '$firstName $lastName';

  factory CustomerEntity.fromJson(Map<String, dynamic> json, String id) {
    return CustomerEntity(
      id: id,
      businessId: json['businessId'] as String? ?? '',
      firstName: json['firstName'] as String? ?? '',
      lastName: json['lastName'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      email: json['email'] as String?,
      notes: json['notes'] as String?,
      totalVisits: json['totalVisits'] as int? ?? 0,
      totalSpent: json['totalSpent'] as int? ?? 0,
      createdAt: json['createdAt'] != null 
          ? DateTime.parse(json['createdAt'].toString()) 
          : DateTime.now(),
      lastVisitAt: json['lastVisitAt'] != null 
          ? DateTime.parse(json['lastVisitAt'].toString()) 
          : null,
      isActive: json['isActive'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'businessId': businessId,
      'firstName': firstName,
      'lastName': lastName,
      'phone': phone,
      'email': email,
      'notes': notes,
      'totalVisits': totalVisits,
      'totalSpent': totalSpent,
      'createdAt': createdAt.toIso8601String(),
      'lastVisitAt': lastVisitAt?.toIso8601String(),
      'isActive': isActive,
    };
  }
}
