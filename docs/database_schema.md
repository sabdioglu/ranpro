# RANPRO Database Schema

## Collections

### 1-8. users, businesses, services, serviceGroups, staff, customers, workingHours, blockedTimes
(Önceki aşamalarda tanımlandı ve uygulandı.)

### 9. appointments
İşletmenin randevu kayıtları.
- `id` (String, Document ID)
- `businessId` (String)
- `staffId` (String)
- `customerId` (String)
- `serviceId` (String)
- `startDateTime` (String, ISO8601)
- `endDateTime` (String, ISO8601)
- `status` (String: 'pending', 'confirmed', 'cancelled', 'completed')
- `notes` (String, nullable)
- `price` (Number/Integer: Kuruş cinsinden, hizmetin o anki fiyatı kopyalanır)
- `createdAt` (Timestamp)
