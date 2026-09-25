class BlockedTimeEntity {
  final String id;
  final String businessId;
  final String? staffId;
  final DateTime startTime;
  final DateTime endTime;
  final String? reason;
  final bool isActive;

  const BlockedTimeEntity({
    required this.id,
    required this.businessId,
    this.staffId,
    required this.startTime,
    required this.endTime,
    this.reason,
    this.isActive = true,
  });

  factory BlockedTimeEntity.fromJson(Map<String, dynamic> json, String id) {
    return BlockedTimeEntity(
      id: id,
      businessId: json['businessId'] as String? ?? '',
      staffId: json['staffId'] as String?,
      startTime: DateTime.parse(json['startTime'].toString()),
      endTime: DateTime.parse(json['endTime'].toString()),
      reason: json['reason'] as String?,
      isActive: json['isActive'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'businessId': businessId,
      'staffId': staffId,
      'startTime': startTime.toUtc().toIso8601String(),
      'endTime': endTime.toUtc().toIso8601String(),
      'reason': reason,
      'isActive': isActive,
    };
  }
}
