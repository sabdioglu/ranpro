# RANPRO Project Memory

## Proje Kimliği
- **Proje:** RANPRO (Profesyonel Randevu ve İşletme Yönetimi)
- **Package:** com.ranpro.app
- **Framework:** Flutter (Dart)
- **UI:** Material 3
- **State Management:** Riverpod
- **Navigation:** go_router
- **Backend:** Firebase (Auth, Firestore, Storage, FCM)

## Ana Kurallar
1. Tek codebase, çoklu platform (Android, iOS, Web).
2. Multi-tenant architecture (İşletmeler arası mutlak veri izolasyonu).
3. Her dosya Single Responsibility kuralına uyar.
4. Karmaşık business logic, UI dosyalarına yazılmaz.
5. Admin panel ve Public Booking route'ları normal kullanıcı panelinden ayrılır.

## Referans Belgeler
- architecture.md
- database_schema.md
- security_rules.md
- development_progress.md
- changelog.md

