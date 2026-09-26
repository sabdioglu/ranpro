# Development Progress

## STAGE 0 - 13
- [x] Temel mimari, Auth, Business, Services, Service Groups, Staff, Customers, Working Hours, Blocked Times tamamlandı.

## STAGE 14
- [x] Randevular (Appointments) Domain/Data katmanları oluşturuldu.
- [x] Takvim Ekranı (calendar_screen) ve state yönetimi (calendar_view_model) eklendi.
- [x] Randevu UI Kartı (appointment_card.dart) oluşturuldu, durum (status) renk kodları ayarlandı.

## STAGE 15
- [x] Randevu Oluşturma View Model (create_appointment_view_model) eklendi (StateNotifier ile adım yönetimi).
- [x] Stepper tabanlı Randevu Oluşturma UI altyapısı (create_appointment_screen) kuruldu.
- [x] Hizmet, Personel, Müşteri seçimi adımları mevcut Riverpod provider'ları ile entegre edildi.
- [ ] Tarih/Saat Seçimi Adımı (Availability Engine gerektiriyor - Stage 16).
