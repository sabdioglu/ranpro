class ServiceGroup {
  final String id;
  final String businessId;
  final String name;
  final int order;
  final bool isActive;

  const ServiceGroup({
    required this.id,
    required this.businessId,
    required this.name,
    this.order = 0,
    this.isActive = true,
  });

  factory ServiceGroup.fromJson(Map<String, dynamic> json, String id) {
    return ServiceGroup(
      id: id,
      businessId: json['businessId'] as String? ?? '',
      name: json['name'] as String? ?? '',
      order: json['order'] as int? ?? 0,
      isActive: json['isActive'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'businessId': businessId,
      'name': name,
      'order': order,
      'isActive': isActive,
    };
  }
}
