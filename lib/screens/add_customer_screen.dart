import 'package:flutter/material.dart';

class AddCustomerScreen extends StatefulWidget {
  const AddCustomerScreen({Key? key}) : super(key: key);

  @override
  State<AddCustomerScreen> createState() => _AddCustomerScreenState();
}

class _AddCustomerScreenState extends State<AddCustomerScreen> {
  // Seçili Cinsiyet
  String _selectedGender = 'Kadın';
  
  // Seçili Hizmet Tercihleri
  final List<String> _selectedServices = ['Saç Kesimi', 'Saç Boyama', 'Cilt Bakımı'];
  
  // Üst Sekmelerdeki Seçili Tab
  int _selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () {
             // İleride önceki sayfaya dönmek için kullanılacak
             // Navigator.pop(context);
          },
        ),
        title: const Text('Müşteri Ekle', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
      ),
      body: Column(
        children: [
          // Üst Sekmeler (Genel Bilgiler, İletişim vb.)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey[200]!)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildTab('Genel Bilgiler', 0),
                _buildTab('İletişim', 1),
                _buildTab('Hizmetler', 2),
                _buildTab('Notlar', 3),
              ],
            ),
          ),

          // Form Alanı (Kaydırılabilir)
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Ad Soyad
                  _buildTextField(icon: Icons.person_outline, label: 'Ad *'),
                  const SizedBox(height: 16),
                  _buildTextField(icon: Icons.person_outline, label: 'Soyad *'),
                  const SizedBox(height: 24),

                  // Cinsiyet
                  const Row(
                    children: [
                      Icon(Icons.wc, color: Colors.grey, size: 20),
                      SizedBox(width: 12),
                      Text('Cinsiyet', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(child: _buildGenderButton('Kadın')),
                      const SizedBox(width: 8),
                      Expanded(child: _buildGenderButton('Erkek')),
                      const SizedBox(width: 8),
                      Expanded(child: _buildGenderButton('Diğer')),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Doğum Tarihi
                  _buildTextField(icon: Icons.calendar_today_outlined, label: 'Doğum Tarihi', suffixIcon: Icons.calendar_month),
                  const SizedBox(height: 16),

                  // Telefon ve E-posta
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey[300]!),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.flag, color: Colors.red, size: 18), // Türk bayrağı temsili
                            SizedBox(width: 4),
                            Text('+90', style: TextStyle(fontWeight: FontWeight.bold)),
                            Icon(Icons.arrow_drop_down),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(child: _buildTextField(icon: Icons.phone_outlined, label: 'Telefon')),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(icon: Icons.email_outlined, label: 'E-posta'),
                  const SizedBox(height: 16),
                  _buildTextField(icon: Icons.location_on_outlined, label: 'Adres'),
                  const SizedBox(height: 24),

                  // Hizmet Tercihleri
                  const Row(
                    children: [
                      Icon(Icons.spa_outlined, color: Colors.grey, size: 20),
                      SizedBox(width: 12),
                      Text('Hizmet Tercihleri', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: [
                      _buildServiceChip('Saç Kesimi'),
                      _buildServiceChip('Saç Boyama'),
                      _buildServiceChip('Cilt Bakımı'),
                      _buildServiceChip('Manikür'),
                      _buildServiceChip('Masaj'),
                      _buildServiceChip('Diğer'),
                      // Ekleme Butonu (Artı işareti)
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.add, size: 16, color: Colors.black54),
                      )
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Notlar
                  _buildTextField(
                    icon: Icons.note_alt_outlined, 
                    label: 'Notlar', 
                    hint: 'Müşteri hakkında not ekleyin...',
                    maxLines: 3,
                  ),
                  
                  const SizedBox(height: 40), // Alt Buton için boşluk
                ],
              ),
            ),
          ),
        ],
      ),
      // Müşteriyi Kaydet Butonu (Sabit alt kısım)
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
              Icon(Icons.save_outlined),
              SizedBox(width: 8),
              Text('Müşteriyi Kaydet', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }

  // Üst Sekmeler
  Widget _buildTab(String title, int index) {
    bool isActive = _selectedTabIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTabIndex = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFFFF5722) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isActive ? Colors.white : Colors.grey[600],
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  // Form Metin Kutuları
  Widget _buildTextField({required IconData icon, required String label, IconData? suffixIcon, String? hint, int maxLines = 1}) {
    return TextField(
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon, color: Colors.grey),
        suffixIcon: suffixIcon != null ? Icon(suffixIcon, color: Colors.grey) : null,
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

  // Cinsiyet Butonları
  Widget _buildGenderButton(String title) {
    bool isSelected = _selectedGender == title;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedGender = title;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFFF0EB) : Colors.white,
          border: Border.all(color: isSelected ? const Color(0xFFFF5722) : Colors.grey[300]!),
          borderRadius: BorderRadius.circular(12),
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? const Color(0xFFFF5722) : Colors.grey[700],
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  // Hizmet Tercihi Etiketleri (Chip)
  Widget _buildServiceChip(String label) {
    bool isSelected = _selectedServices.contains(label);
    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            _selectedServices.remove(label);
          } else {
            _selectedServices.add(label);
          }
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.grey[800] : Colors.grey[100],
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: isSelected ? Colors.grey[800]! : Colors.grey[300]!),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black87,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}
