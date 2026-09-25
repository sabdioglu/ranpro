# Development Progress

## STAGE 0 - 10
- [x] Temel mimari, Auth, Business, Services, Service Groups, Staff (Data + UI) tamamlandı.

## STAGE 11
- [x] Müşteriler (Customers) Domain/Data altyapısı oluşturuldu.
- [x] Müşteriler View Model (customers_view_model.dart) oluşturuldu.
- [x] Müşteri Liste Ekranı (customers_screen.dart) oluşturuldu. Toplam harcama kuruş formatından double formata çevrilerek gösterildi.
- [x] Müşteri Ekle/Düzenle Ekranı (add_edit_customer_screen.dart) oluşturuldu.
- [ ] Detaylı Müşteri Geçmişi (Randevular oluştuktan sonra eklenecek).

## STAGE 12
- [x] Çalışma Saatleri (Working Hours) Firestore koleksiyonu şemaya eklendi. (İşletme ve Personel kırılımı ayrıldı).
- [x] Çalışma Saatleri Entity, Repository, DataSource oluşturuldu.
- [x] Firestore `WriteBatch` kullanılarak toplu çalışma saati kaydetme (batchUpdate) işlemi entegre edildi.
- [x] Çalışma Saatleri Riverpod Provider'ları (business & staff ayrımıyla) bağlandı.
- [ ] Çalışma Saatleri UI (Ayarlar/Personel içinden düzenleme ekranları) eklenecek.
