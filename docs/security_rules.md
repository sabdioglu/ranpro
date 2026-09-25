# RANPRO Firestore Security Rules (Taslak)

Bu kurallar uygulamanın multi-tenant yapısını Firebase sunucu tarafında güvence altına alır.
Gerçek Firebase projesine deploy edilmelidir.

```text
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    
    // Yardımcı Fonksiyonlar
    function isAuthenticated() {
      return request.auth != null;
    }
    
    function getUserData() {
      return get(/databases/$(database)/documents/users/$(request.auth.uid)).data;
    }
    
    function isOwnerOfBusiness(businessId) {
      return isAuthenticated() && getUserData().businessId == businessId && (getUserData().role == 'business_owner' || getUserData().role == 'admin');
    }
    
    function isStaffOfBusiness(businessId) {
      return isAuthenticated() && getUserData().businessId == businessId;
    }

    // Kullanıcılar Koleksiyonu
    match /users/{userId} {
      // Kullanıcı kendi verisini okuyabilir. Admin herkesi okuyabilir.
      allow read: if isAuthenticated() && (request.auth.uid == userId || getUserData().role == 'admin');
      // Sadece admin veya cloud function yazabilir.
      allow write: if isAuthenticated() && getUserData().role == 'admin';
    }

    // İşletmeler Koleksiyonu
    match /businesses/{businessId} {
      // İşletme personeli ve sahibi işletme detayını okuyabilir.
      allow read: if isStaffOfBusiness(businessId) || isOwnerOfBusiness(businessId);
      // Sadece işletme sahibi veya admin güncelleyebilir.
      allow write: if isOwnerOfBusiness(businessId);
    }
    
    // Diğer koleksiyonlar (müşteriler, randevular vb.) her zaman businessId kontrolü yapacaktır.
    // Örnek: allow read: if isStaffOfBusiness(resource.data.businessId);
  }
}
