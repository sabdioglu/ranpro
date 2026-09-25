class ServiceEntity {
  final String id;
  final String businessId;
  final String name;
  final String? description;
  final int durationInMinutes;
  final int price; // Para değeri int (Kuruş) olarak tutulur. 100 TL = 10000
  final bool isActive;

  const ServiceEntity({
    required this.id,
    required this.businessId,
    required this.name,
    this.description,
    required this.durationInMinutes,
    required this.price,
    this.isActive = true,
  });

  factory ServiceEntity.fromJson(Map<String, dynamic> json, String id) {
    return ServiceEntity(
      id: id,
      businessId: json['businessId'] as String? ?? '',
      name: json['name'] as String? ?? '',
      description: json['description'] as String?,
      durationInMinutes: json['durationInMinutes'] as int? ?? 30,
      price: json['price'] as int? ?? 0,
      isActive: json['isActive'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'businessId': businessId,
      'name': name,
      'description': description,
      'durationInMinutes': durationInMinutes,
      'price': price,
      'isActive': isActive,
    };
  }
}
