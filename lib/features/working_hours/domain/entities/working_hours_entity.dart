class WorkingHoursEntity {
  final String id;
  final String businessId;
  final String? staffId; // null ise işletme geneli, dolu ise personel özel çalışma saati
  final int dayOfWeek; // 1: Pazartesi, 2: Salı ... 7: Pazar
  final String startTime; // "09:00"
  final String endTime; // "18:00"
  final bool isClosed;

  const WorkingHoursEntity({
    required this.id,
    required this.businessId,
    this.staffId,
    required this.dayOfWeek,
    required this.startTime,
    required this.endTime,
    this.isClosed = false,
  });

  factory WorkingHoursEntity.fromJson(Map<String, dynamic> json, String id) {
    return WorkingHoursEntity(
      id: id,
      businessId: json['businessId'] as String? ?? '',
      staffId: json['staffId'] as String?,
      dayOfWeek: json['dayOfWeek'] as int? ?? 1,
      startTime: json['startTime'] as String? ?? '09:00',
      endTime: json['endTime'] as String? ?? '18:00',
      isClosed: json['isClosed'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'businessId': businessId,
      'staffId': staffId,
      'dayOfWeek': dayOfWeek,
      'startTime': startTime,
      'endTime': endTime,
      'isClosed': isClosed,
    };
  }
}
