import 'package:flutter/material.dart';

class CreateAppointmentScreen extends StatefulWidget {
  const CreateAppointmentScreen({Key? key}) : super(key: key);

  @override
  State<CreateAppointmentScreen> createState() => _CreateAppointmentScreenState();
}

class _CreateAppointmentScreenState extends State<CreateAppointmentScreen> {
  // Müşteri ve Misafir sekmeleri arasında geçiş yapmak için kullanacağımız durum
  bool isMisafirSelected = true; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        // SOL ÜSTTEKİ GERİ BUTONUNU ÇALIŞTIRAN KOD
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // Önceki sayfaya (Ana Sayfaya) dön
          },
        ),
        title: const Text('Randevu Oluştur', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // MÜŞTERİ / MİSAFİR GEÇİŞ BUTONLARI (Artık Tıklanabilir)
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() { isMisafirSelected = false; });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: !isMisafirSelected ? Colors.white : Colors.transparent,
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: !isMisafirSelected ? [const BoxShadow(color: Colors.black12, blurRadius: 4)] : [],
                          ),
                          child: Center(
                            child: Text('Müşteri', style: TextStyle(fontWeight: !isMisafirSelected ? FontWeight.bold : FontWeight.normal, color: !isMisafirSelected ? Colors.black : Colors.grey)),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() { isMisafirSelected = true; });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: isMisafirSelected ? Colors.white : Colors.transparent,
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: isMisafirSelected ? [const BoxShadow(color: Colors.black12, blurRadius: 4)] : [],
                          ),
                          child: Center(
                            child: Text('Misafir', style: TextStyle(fontWeight: isMisafirSelected ? FontWeight.bold : FontWeight.normal, color: isMisafirSelected ? Colors.black : Colors.grey)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // TIKLANABİLİR SEÇİM LİSTELERİ
              _buildInteractiveRow(Icons.person_outline, 'Müşteri seçin'),
              const Divider(),
              _buildInteractiveRow(Icons.spa_outlined, 'Hizmet seçin'),
              const Divider(),
              _buildInteractiveRow(Icons.badge_outlined, 'Personel seçin'),
              const Divider(),
              _buildInteractiveRow(Icons.calendar_today_outlined, '18 Eylül 2026'),
              const Divider(),
              _buildInteractiveRow(Icons.access_time, '10:30'),
              const Divider(),
              
              const SizedBox(height: 24),
              
              // NOT EKLEME ALANI (Artık içine yazı yazılabilir)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: const TextField(
                  maxLines: 3,
                  decoration: InputDecoration(
                    icon: Icon(Icons.edit_note, color: Colors.grey),
                    border: InputBorder.none,
                    hintText: 'Not ekleyin...',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
      
      // EN ALTTAKİ RANDEVU OLUŞTUR BUTONU (Artık Çalışıyor)
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: () {
              // Butona basıldığında yeşil bir bildirim çıkar ve Ana Sayfaya döner
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Randevu başarıyla oluşturuldu!'), 
                  backgroundColor: Colors.green,
                  duration: Duration(seconds: 2),
                ),
              );
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF5722),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 2,
            ),
            child: const Text('Randevu Oluştur', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
          ),
        ),
      ),
    );
  }

  // Satırların tıklanabilir olmasını sağlayan fonksiyon
  Widget _buildInteractiveRow(IconData icon, String text) {
    return InkWell(
      onTap: () {
        // İleride buraya açılır pencereler (Dropdown) eklenecek
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$text menüsü açılacak...'), duration: const Duration(seconds: 1)),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          children: [
            Icon(icon, color: Colors.grey, size: 22),
            const SizedBox(width: 16),
            Expanded(child: Text(text, style: const TextStyle(color: Colors.black87, fontSize: 15))),
            const Icon(Icons.chevron_right, color: Colors.grey, size: 20),
          ],
        ),
      ),
    );
  }
}
