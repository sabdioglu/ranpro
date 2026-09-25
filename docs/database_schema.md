# RANPRO Database Schema

## Collections

### 1. users
Kullanıcı kimlik, rol ve tenant (işletme) eşleştirmesini tutar.
- `uid` (String, Document ID)
- `email` (String)
- `displayName` (String)
- `role` (String: 'super_admin', 'admin', 'business_owner', 'staff', 'customer')
- `businessId` (String, nullable: Eğer kullanıcı bir işletmeye bağlıysa)
- `createdAt` (Timestamp)
- `isActive` (Boolean)

### 2. businesses
İşletme temel profili.
- `businessId` (String, Document ID)
- `name` (String)
- `logoUrl` (String, nullable)
- `phone` (String, nullable)
- `address` (String, nullable)
- `description` (String, nullable)
- `isActive` (Boolean)

### 3. services
İşletmenin sunduğu hizmetler. Multi-tenant güvenlik gereği her hizmet bir işletmeye aittir.
- `id` (String, Document ID)
- `businessId` (String)
- `name` (String)
- `description` (String, nullable)
- `durationInMinutes` (Number/Integer)
- `price` (Number/Integer: Kuruş cinsinden. Örn: 100 TL = 10000)
- `isActive` (Boolean)
