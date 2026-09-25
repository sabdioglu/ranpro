# RANPRO Database Schema

## Collections

### 1-7. users, businesses, services, serviceGroups, staff, customers, workingHours
(Önceki aşamalarda tanımlandı ve uygulandı.)

### 8. blockedTimes
İşletmenin veya personelin randevu alamayacağı özel tarihler, izinler, molalar veya kapalı günler.
- `id` (String, Document ID)
- `businessId` (String)
- `staffId` (String, nullable) // İşletme geneli kapalıysa null.
- `startTime` (Timestamp)
- `endTime` (Timestamp)
- `reason` (String, nullable) // Örn: "Öğle Molası", "Yıllık İzin", "Tadilat"
- `isActive` (Boolean)
