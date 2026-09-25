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

### 2. businesses (Stage 5 Devamında Detaylandırılacak)
İşletme temel profili.
- `businessId` (String, Document ID)
- `name` (String)
- `isActive` (Boolean)
