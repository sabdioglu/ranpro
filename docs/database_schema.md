# RANPRO Database Schema

## Collections

### 1-6. users, businesses, services, serviceGroups, staff, customers
(Önceki aşamalarda tanımlandı ve uygulandı.)

### 7. workingHours
İşletmenin veya personelin haftalık çalışma saatleri (Pazartesi-Pazar).
- `id` (String, Document ID)
- `businessId` (String)
- `staffId` (String, nullable) // Eğer null ise bu işletmenin genel çalışma saatidir. Dolu ise o personelin özel çalışma saatidir.
- `dayOfWeek` (Number/Integer: 1=Pazartesi, 7=Pazar)
- `startTime` (String: "09:00" formatında)
- `endTime` (String: "18:00" formatında)
- `isClosed` (Boolean) // O gün kapalı/izinli mi?
