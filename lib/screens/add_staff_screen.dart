import 'package:flutter/material.dart';

class AddStaffScreen extends StatefulWidget {
  const AddStaffScreen({Key? key}) : super(key: key);

  @override
  State<AddStaffScreen> createState() => _AddStaffScreenState();
}

class _AddStaffScreenState extends State<AddStaffScreen> {
  // Görseldeki gibi "Şifre" (4. indeks) sekmesi varsayılan olarak açık gelsin
  int _selectedTabIndex = 4; 
  
  // Şifreleri gizle/göster
  bool _obscureTempPassword = true;
  bool _obscureRepeatPassword = true;

  // Yetki şalterlerinin durumları (Görseldeki gibi ayarlandı)
  bool _manageAppointments = true;
  bool _viewCustomers = true;
  bool _manageFinances = false;
  bool _viewReports = false;
  bool _changeSettings = false;

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
        title: const Text('Personel Ekle', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
      ),
      body: Column(
        children: [
          // Üst Sekmeler (Yatay kaydırılabilir)
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              children: [
                _buildTab('Bilgiler', 0),
                const SizedBox(width: 8),
                _buildTab('Uzmanlık', 1),
                const SizedBox(width: 8),
                _buildTab('Çalışma', 2),
                const SizedBox(width: 8),
                _buildTab('Maaş', 3),
                const SizedBox(width: 8),
                _buildTab('Şifre', 4),
              ],
            ),
          ),
          const Divider(height: 1),

          // İçerik Alanı
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Kullanıcı Adı
                  _buildTextField(icon: Icons.person_outline, label: 'Kullanıcı Adı *'),
                  const SizedBox(height: 16),
                  
                  // Geçici Şifre
                  _buildPasswordField(
                    icon: Icons.lock_outline, 
                    label: 'Geçici Şifre *', 
                    obscureText: _obscureTempPassword,
                    onToggle: () {
                      setState(() {
                        _obscureTempPassword = !_obscureTempPassword;
                      });
                    }
                  ),
                  const SizedBox(height: 16),

                  // Şifreyi Tekrarla
                  _buildPasswordField(
                    icon: Icons.lock_outline, 
                    label: 'Şifreyi Tekrarla *', 
                    obscureText: _obscureRepeatPassword,
                    onToggle: () {
                      setState(() {
                        _obscureRepeatPassword = !_obscureRepeatPassword;
                      });
                    }
                  ),
                  const SizedBox(height: 24),

                  // Yetki Düzeyi
                  const Text('Yetki Düzeyi', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black87)),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: 'Personel',
                        icon: const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
                        items: <String>['Personel', 'Yönetici', 'Kasiyer'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (_) {},
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Yetki Şalterleri
                  _buildPermissionSwitch('Randevuları Yönetme', Icons.calendar_month, _manageAppointments, (val) => setState(() => _manageAppointments = val)),
                  _buildPermissionSwitch('Müşterileri Görüntüleme', Icons.people_outline, _viewCustomers, (val) => setState(() => _viewCustomers = val)),
                  _buildPermissionSwitch('Gelir / Gider İşlemleri', Icons.account_balance_wallet_outlined, _manageFinances, (val) => setState(() => _manageFinances = val)),
                  _buildPermissionSwitch('Raporları Görüntüleme', Icons.bar_chart, _viewReports, (val) => setState(() => _viewReports = val)),
                  _buildPermissionSwitch('Ayarları Değiştirme', Icons.settings_outlined, _changeSettings, (val) => setState(() => _changeSettings = val)),
                  
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
      
      // Personeli Kaydet Butonu
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -4))],
        ),
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFF5722),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 0,
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.person_add_alt_1),
              SizedBox(width: 8),
              Text('Personeli Kaydet', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
            ],
          ),
        ),
      ),
    );
  }

  // Üst Sekme Tasarımı
  Widget _buildTab(String title, int index) {
    bool isActive = _selectedTabIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTabIndex = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFFFF5722) : Colors.grey[100],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isActive ? Colors.white : Colors.grey[700],
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  // Normal Metin Kutusu
  Widget _buildTextField({required IconData icon, required String label}) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFFF5722)),
        ),
        filled: true,
        fillColor: Colors.grey[50],
      ),
    );
  }

  // Şifre Kutusu (Göz ikonlu)
  Widget _buildPasswordField({required IconData icon, required String label, required bool obscureText, required VoidCallback onToggle}) {
    return TextField(
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.grey),
        suffixIcon: IconButton(
          icon: Icon(obscureText ? Icons.visibility_off : Icons.visibility, color: Colors.grey),
          onPressed: onToggle,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFFF5722)),
        ),
        filled: true,
        fillColor: Colors.grey[50],
      ),
    );
  }

  // Şalter (Switch) Satırı
  Widget _buildPermissionSwitch(String title, IconData icon, bool value, ValueChanged<bool> onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.grey[500], size: 22), 
              const SizedBox(width: 12),
              Text(title, style: const TextStyle(fontSize: 15, color: Colors.black87)),
            ],
          ),
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
}
