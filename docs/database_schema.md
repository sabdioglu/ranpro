# RANPRO Database Schema

## Collections

### 1-7. users, businesses, services, serviceGroups, staff, customers, workingHours
(Önceki aşamalarda tanımlandı ve uygulandı.)

### 8. blockedTimes
Müsaitliği kapatan istisnai durumları tutar (Öğle molası, personel izni, tadilat, resmi tatil vb.)
- `id` (String, Document ID)
- `businessId` (String)
- `staffId` (String, nullable) // Sadece belli bir personelin izni/molası ise dolu. Tüm işletme kapalıysa null.
- `title` (String) // "Öğle Molası", "Yıllık İzin", "Tadilat"
- `startDateTime` (String, ISO8601) // Başlangıç tarih ve saati
- `endDateTime` (String, ISO8601) // Bitiş tarih ve saati
- `isAllDay` (Boolean) // Tüm gün mü?
