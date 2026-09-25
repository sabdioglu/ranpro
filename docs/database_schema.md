# RANPRO Database Schema

## Collections

### 1. users
- `uid` (String, Document ID)
- `email` (String)
- `displayName` (String)
- `role` (String)
- `businessId` (String, nullable)
- `createdAt` (Timestamp)
- `isActive` (Boolean)

### 2. businesses
- `businessId` (String, Document ID)
- `name` (String)
- `logoUrl` (String, nullable)
- `phone` (String, nullable)
- `address` (String, nullable)
- `description` (String, nullable)
- `isActive` (Boolean)

### 3. services
- `id` (String, Document ID)
- `businessId` (String)
- `name` (String)
- `description` (String, nullable)
- `durationInMinutes` (Number/Integer)
- `price` (Number/Integer: Kuruş cinsinden)
- `isActive` (Boolean)
- `groupId` (String, nullable)

### 4. serviceGroups
- `id` (String, Document ID)
- `businessId` (String)
- `name` (String)
- `order` (Number/Integer: Sıralama için)
- `isActive` (Boolean)

### 5. staff
İşletmede çalışan personellerin profil ve temel yapılandırma bilgileri.
- `id` (String, Document ID)
- `businessId` (String)
- `firstName` (String)
- `lastName` (String)
- `photoUrl` (String, nullable)
- `phone` (String, nullable)
- `email` (String, nullable)
- `position` (String, nullable) // Örn: Kıdemli Stilist, Terapist
- `serviceIds` (Array of Strings) // Personelin verebildiği hizmetlerin ID'leri
- `isActive` (Boolean)
// Çalışma saatleri ve komisyon oranları ayrı özelliklerde veya alt koleksiyonlarda yönetilecektir.
