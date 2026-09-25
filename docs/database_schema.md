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
- `order` (Number/Integer)
- `isActive` (Boolean)

### 5. staff
- `id` (String, Document ID)
- `businessId` (String)
- `firstName` (String)
- `lastName` (String)
- `photoUrl` (String, nullable)
- `phone` (String, nullable)
- `email` (String, nullable)
- `position` (String, nullable)
- `serviceIds` (Array of Strings)
- `isActive` (Boolean)

### 6. customers
İşletmenin müşteri kayıtları.
- `id` (String, Document ID)
- `businessId` (String)
- `firstName` (String)
- `lastName` (String)
- `phone` (String)
- `email` (String, nullable)
- `notes` (String, nullable)
- `totalVisits` (Number/Integer)
- `totalSpent` (Number/Integer: Kuruş cinsinden)
- `createdAt` (Timestamp)
- `lastVisitAt` (Timestamp, nullable)
- `isActive` (Boolean)
