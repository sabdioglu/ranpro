class AppUser {
  final String uid;
  final String? email;
  final String? displayName;
  final String? businessId;
  final String role; // 'admin', 'business_owner', 'staff', 'customer'

  const AppUser({
    required this.uid,
    this.email,
    this.displayName,
    this.businessId,
    required this.role,
  });

  bool get isAdmin => role == 'admin' || role == 'super_admin';
  bool get isBusinessOwner => role == 'business_owner';
}
