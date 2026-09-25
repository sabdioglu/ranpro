class BlockedTimeEntity {
  final String id;
  final String businessId;
  final String? staffId; // null ise tüm işletme kapalıdır
  final String title;
  final DateTime startDateTime;
  final DateTime endDateTime;
  final bool isAllDay;

  const BlockedTimeEntity({
    required this.id,
    required this.businessId,
    this.staffId,
    required this.title,
    required this.startDateTime,
    required this.endDateTime,
    this.isAllDay = false,
  });

  factory BlockedTimeEntity.fromJson(Map<String, dynamic> json, String id) {
    return BlockedTimeEntity(
      id: id,
      businessId: json['businessId'] as String? ?? '',
      staffId: json['staffId'] as String?,
      title: json['title'] as String? ?? '',
      startDateTime: json['startDateTime'] != null 
          ? DateTime.parse(json['startDateTime'].toString()) 
          : DateTime.now(),
      endDateTime: json['endDateTime'] != null 
          ? DateTime.parse(json['endDateTime'].toString()) 
          : DateTime.now().add(const Duration(hours: 1)),
      isAllDay: json['isAllDay'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'businessId': businessId,
      'staffId': staffId,
      'title': title,
      'startDateTime': startDateTime.toIso8601String(),
      'endDateTime': endDateTime.toIso8601String(),
      'isAllDay': isAllDay,
    };
  }
}
