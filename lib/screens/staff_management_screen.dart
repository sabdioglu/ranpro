import 'package:flutter/material.dart';

class StaffManagementScreen extends StatefulWidget {
  const StaffManagementScreen({Key? key}) : super(key: key);

  @override
  State<StaffManagementScreen> createState() => _StaffManagementScreenState();
}

class _StaffManagementScreenState extends State<StaffManagementScreen> {
  // Ayar Şalterlerinin Durumları
  bool _requireName = true;
  bool _requirePhone = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () {},
        ),
        title: const Text('Personel Yönetimi', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Kategori Başlığı: MANUEL RANDEVU AYARLARI
            Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 16.0, bottom: 8.0),
              child: Text(
                'MANUEL RANDEVU AYARLARI',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.grey[500], letterSpacing: 0.5),
              ),
            ),
            
            // Ayar: Ad soyad zorunlu olsun
            _buildSwitchTile(
              title: 'Ad soyad zorunlu olsun',
              subtitle: 'Manuel randevularda müşterinin ad soyadını zorunlu tutar.',
              value: _requireName,
              onChanged: (val) => setState(() => _requireName = val),
            ),
            const Divider(height: 1),

            // Ayar: Telefon numarası zorunlu olsun
            _buildSwitchTile(
              title: 'Telefon numarası zorunlu olsun',
              subtitle: 'Manuel randevularda müşterinin telefonunu zorunlu tutar.',
              value: _requirePhone,
              onChanged: (val) => setState(() => _requirePhone = val),
            ),
            const SizedBox(height: 24),

            // Kategori Başlığı: PERSONEL
            Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 16.0, bottom: 8.0),
              child: Text(
                'PERSONEL',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.grey[500], letterSpacing: 0.5),
              ),
            ),

            // Personel Listesi
            _buildStaffTile(
              initial: 'S',
              name: 'Şeyhmus ABDİOĞLU',
              email: 'icselmerkez@gmail.com',
              serviceCount: '1 Hizmet',
            ),
            
            // Eğer birden fazla personel eklenecekse buraya kopyalanabilir.
            
          ],
        ),
      ),
    );
  }

  // Şalterli Ayar Satırı Tasarımı
  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87)),
                const SizedBox(height: 4),
                Text(subtitle, style: TextStyle(fontSize: 13, color: Colors.grey[600], height: 1.3)),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: const Color(0xFFFF5722),
            activeTrackColor: const Color(0xFFFF5722).withOpacity(0.3),
          ),
        ],
      ),
    );
  }

  // Personel Liste Elemanı Tasarımı
  Widget _buildStaffTile({
    required String initial,
    required String name,
    required String email,
    required String serviceCount,
  }) {
    return InkWell(
      onTap: () {}, // Personel detayına git
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Row(
          children: [
            // Yuvarlak Baş Harf Logosu
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey[300]!),
              ),
              alignment: Alignment.center,
              child: Text(
                initial,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black54),
              ),
            ),
            const SizedBox(width: 16),
            
            // İsim, E-posta ve Hizmet Sayısı
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87)),
                  const SizedBox(height: 2),
                  Text(email, style: TextStyle(fontSize: 13, color: Colors.grey[600])),
                  const SizedBox(height: 4),
                  Text(serviceCount, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Color(0xFFFF5722))),
                ],
              ),
            ),
            
            // Sağ Ok İkonu
            Icon(Icons.chevron_right, color: Colors.grey[400]),
          ],
        ),
      ),
    );
  }
}
