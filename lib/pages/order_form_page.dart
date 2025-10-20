import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_helloworld/model/motor.dart';

class AppColors {
  static const Color primaryLight = Color(0xFF00264D);
  static const Color accentLight = Color(0xFF0055A4);
  static const Color primaryDark = Color(0xFF0B3A66);
  static const Color accentDark = Color(0xFF4EA0FF);
}

class OrderFormPage extends StatefulWidget {
  final Motor motor; 
  final bool darkMode;

  const OrderFormPage({
    super.key,
    required this.motor,
    required this.darkMode,
  });

  @override
  State<OrderFormPage> createState() => _OrderFormPageState();
}

class _OrderFormPageState extends State<OrderFormPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    nameController.dispose();
    addressController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  Future<void> _submitOrder() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 2)); // Simulasi aja

    if (!mounted) return;
    setState(() => _isLoading = false);

    _showSuccessDialog();
  }

  void _showSuccessDialog() {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierLabel: '',
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (context, anim1, anim2) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Animate(
            effects: const [FadeEffect(), ScaleEffect(curve: Curves.easeOutBack)],
            child: AlertDialog(
              backgroundColor: widget.darkMode ? const Color(0xFF1E293B) : Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
              title: const Center(child: Icon(Icons.check_circle_rounded, color: Colors.green, size: 70)),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Pemesanan Berhasil!', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Text(
                    'Terima kasih ${nameController.text},\nPesanan ${widget.motor.name} Anda akan segera kami proses.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15, color: Colors.grey[600]),
                  ),
                ],
              ),
              actionsAlignment: MainAxisAlignment.center,
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop(); 
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: widget.darkMode ? AppColors.accentDark : AppColors.accentLight,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  ),
                  child: const Text('Kembali ke Produk', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    final primaryColor = widget.darkMode ? AppColors.primaryDark : AppColors.primaryLight;
    final accentColor = widget.darkMode ? AppColors.accentDark : AppColors.accentLight;
    final pageBgColor = widget.darkMode ? const Color(0xFF0F1724) : const Color(0xFFF4F6FA);
    final textColor = widget.darkMode ? Colors.white : Colors.black87;

    return Scaffold(
      backgroundColor: pageBgColor,
      appBar: AppBar(
        title: Text('Form Pemesanan ${widget.motor.name}'),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Lengkapi Data Pemesanan",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: textColor),
              ),
              const SizedBox(height: 8),
              Text(
                "Silakan isi data diri Anda di bawah ini.",
                style: TextStyle(fontSize: 15, color: textColor.withOpacity(0.7)),
              ),
              const SizedBox(height: 24),

              _buildTextFormField(
                controller: nameController,
                label: 'Nama Lengkap',
                hint: 'Sesuai KTP',
                icon: Icons.person_outline,
                darkMode: widget.darkMode,
              ),
              const SizedBox(height: 16),
              _buildTextFormField(
                controller: addressController,
                label: 'Alamat Pengiriman',
                hint: 'Jalan, Nomor, RT/RW, Kelurahan, Kecamatan...',
                icon: Icons.home_outlined,
                maxLines: 3,
                darkMode: widget.darkMode,
              ),
              const SizedBox(height: 16),
              _buildTextFormField(
                controller: phoneController,
                label: 'Nomor HP Aktif',
                hint: 'Contoh: 081234567890',
                icon: Icons.phone_outlined,
                keyboardType: TextInputType.phone,
                darkMode: widget.darkMode,
              ),
              const SizedBox(height: 32),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _submitOrder,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: accentColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                  child: _isLoading
                      ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 3, color: Colors.white))
                      : const Text("Kirim Pesanan", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ).animate().fadeIn(duration: 500.ms),
        ),
      ),
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    required bool darkMode,
  }) {
    final textColor = darkMode ? Colors.white : Colors.black87;
    final hintColor = darkMode ? Colors.white54 : Colors.grey;
    final fillColor = darkMode ? Colors.white.withOpacity(0.05) : Colors.grey.shade100;

    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      style: TextStyle(color: textColor),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: hintColor),
        hintText: hint,
        hintStyle: TextStyle(color: hintColor.withOpacity(0.7)),
        prefixIcon: Icon(icon, color: hintColor),
        filled: true,
        fillColor: fillColor,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide(color: Colors.grey.shade300)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide(color: darkMode ? AppColors.accentDark : AppColors.accentLight)),
      ),
      validator: (value) => value!.isEmpty ? '$label tidak boleh kosong' : null,
    );
  }
}