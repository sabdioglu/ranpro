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
İşletmenin hizmetlerini kategorize etmek için kullanılır (Örn: Lazer, Cilt Bakımı, Masaj).
- `id` (String, Document ID)
- `businessId` (String)
- `name` (String)
- `order` (Number/Integer: Sıralama için)
- `isActive` (Boolean)
