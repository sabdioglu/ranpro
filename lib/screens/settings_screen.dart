import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

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
        title: const Text('Ayarlar', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        children: [
          _buildSettingsTile(
            icon: Icons.store_outlined,
            iconColor: const Color(0xFFFF5722),
            title: 'İşletme Profili',
            subtitle: 'İşletme bilgilerinizi düzenleyin',
          ),
          _buildSettingsTile(
            icon: Icons.access_time,
            iconColor: Colors.blue,
            title: 'Çalışma Saatleri',
            subtitle: 'Mesai saatlerinizi ayarlayın',
          ),
          _buildSettingsTile(
            icon: Icons.calendar_month_outlined,
            iconColor: Colors.purple,
            title: 'Randevu Ayarları',
            subtitle: 'Randevu kurallarını belirleyin',
          ),
          _buildSettingsTile(
            icon: Icons.language,
            iconColor: Colors.teal,
            title: 'Web Sitesi Ayarları',
            subtitle: 'Randevu sayfası ayarları',
          ),
          _buildSettingsTile(
            icon: Icons.notifications_none,
            iconColor: Colors.orange,
            title: 'Bildirimler',
            subtitle: 'E-posta ve uygulama bildirimleri',
          ),
          _buildSettingsTile(
            icon: Icons.smartphone,
            iconColor: Colors.indigo,
            title: 'Uygulama Ayarları',
            subtitle: 'Tema, dil ve diğer ayarlar',
          ),
          _buildSettingsTile(
            icon: Icons.help_outline,
            iconColor: Colors.green,
            title: 'Yardım & Destek',
            subtitle: 'Sık sorulan sorular',
          ),
          _buildSettingsTile(
            icon: Icons.info_outline,
            iconColor: Colors.grey,
            title: 'Hakkında',
            subtitle: 'Uygulama sürümü ve lisans',
            showDivider: false, // Son eleman olduğu için alt çizgiyi kaldırıyoruz
          ),
          const SizedBox(height: 40), // Alt menü boşluğu
        ],
      ),
    );
  }

  // Ayar Liste Elemanı Tasarımı
  Widget _buildSettingsTile({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    bool showDivider = true,
  }) {
    return Column(
      children: [
        ListTile(
          contentPadding: const EdgeInsets.symmetric(vertical: 4.0),
          leading: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black87),
          ),
          subtitle: Text(
            subtitle,
            style: TextStyle(color: Colors.grey[600], fontSize: 13),
          ),
          trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey[400], size: 16),
          onTap: () {
            // İlgili ayar sayfasına yönlendirme yapılacak
          },
        ),
        if (showDivider)
          Divider(color: Colors.grey[100], height: 1, indent: 64),
      ],
    );
  }
}
