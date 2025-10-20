import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_helloworld/widgets/drawer_widget.dart';

class AppColors {
  static const Color primaryLight = Color(0xFF00264D);
  static const Color accentLight = Color(0xFF0055A4);
  static const Color primaryDark = Color(0xFF0B3A66);
  static const Color accentDark = Color(0xFF4EA0FF);
}

class ServicePage extends StatefulWidget {
  final bool darkMode;
  final String email;
  const ServicePage({
    Key? key,
    this.darkMode = false,
    required this.email,
  }) : super(key: key);

  @override
  State<ServicePage> createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController namaController = TextEditingController();
  final TextEditingController noHpController = TextEditingController();
  final TextEditingController tanggalController = TextEditingController();
  final TextEditingController motorController = TextEditingController();

  String? selectedDealer;
  String? selectedService;
  bool isAgree = false;
  bool _isFormSubmitted = false;

  final List<String> dealerList = [
    'Dealer Yamaha Magetan', 'Dealer Yamaha Madiun',
    'Dealer Yamaha Ponorogo', 'Dealer Yamaha Ngawi',
  ];

  final List<String> serviceTypes = ['Servis Rutin', 'Ganti Oli', 'Cek Kelistrikan', 'Lainnya'];

  Timer? _timer;
  Alignment _beginAlignment = Alignment.topLeft;
  Alignment _endAlignment = Alignment.bottomRight;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (mounted) {
        setState(() {
          _beginAlignment = [Alignment.topRight, Alignment.bottomLeft, Alignment.topLeft, Alignment.bottomRight][timer.tick % 4];
          _endAlignment = [Alignment.bottomLeft, Alignment.topRight, Alignment.bottomRight, Alignment.topLeft][timer.tick % 4];
        });
      }
    });
  }

  @override
  void dispose() {
    namaController.dispose();
    noHpController.dispose();
    tanggalController.dispose();
    motorController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _submitForm() {
    setState(() {
      _isFormSubmitted = true;
    });

    final isFormValid = _formKey.currentState!.validate();
    final isServiceSelected = selectedService != null;

    if (isFormValid && isAgree && isServiceSelected) {
      showGeneralDialog(
        context: context,
        barrierDismissible: true,
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
                    const Text('Booking Berhasil!', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    Text(
                      'Terima kasih ${namaController.text},\nbooking servis Anda di $selectedDealer berhasil disimpan.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 15, color: Colors.grey[600]),
                    ),
                  ],
                ),
                actionsAlignment: MainAxisAlignment.center,
                actions: [
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: widget.darkMode ? AppColors.accentDark : AppColors.accentLight,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                    ),
                    child: const Text('Oke, Siap 🚀', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
          );
        },
      );
    } else if (!isAgree) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Mohon setujui kebijakan terlebih dahulu')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = widget.darkMode ? AppColors.primaryDark : AppColors.primaryLight;
    final accentColor = widget.darkMode ? AppColors.accentDark : AppColors.accentLight;

    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: AppDrawer(email: widget.email, darkMode: widget.darkMode),
      appBar: AppBar(
        title: const Text('Booking Servis'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: AnimatedContainer(
        duration: const Duration(seconds: 4),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: widget.darkMode
                ? [const Color(0xFF0F1724), const Color(0xFF08213A)]
                : [accentColor, primaryColor],
            begin: _beginAlignment,
            end: _endAlignment,
          ),
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 100),
                _buildHeader(),
                const SizedBox(height: 30),
                _buildFormCard(
                  title: "Data Diri",
                  icon: Icons.person,
                  fields: [
                    _buildTextFormField(controller: namaController, label: 'Nama Lengkap', hint: 'Masukkan nama kamu', icon: Icons.person_outline),
                    _buildTextFormField(controller: noHpController, label: 'Nomor HP', hint: 'Masukkan nomor HP aktif', icon: Icons.phone_outlined, keyboardType: TextInputType.phone),
                  ],
                ),
                const SizedBox(height: 20),
                _buildFormCard(
                  title: "Detail Servis",
                  icon: Icons.build_circle,
                  fields: [
                    _buildTextFormField(controller: motorController, label: 'Model Motor & Plat Nomor', hint: 'Contoh: NMAX AB 1234 CD', icon: Icons.motorcycle_outlined),
                    _buildServiceTypeSelector(),
                    _buildDatePickerField(),
                    _buildDealerDropdown(),
                  ],
                ),
                const SizedBox(height: 20),
                _buildAgreement(),
                const SizedBox(height: 30),
                _buildSubmitButton(),
                const SizedBox(height: 40),
              ],
            ).animate().fadeIn(duration: const Duration(milliseconds: 500)),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Jadwalkan Servis Rutin Anda",
          style: const TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold, height: 1.2),
        ),
        const SizedBox(height: 8),
        Text(
          "Pastikan motor Yamaha Anda selalu dalam kondisi prima. Isi form di bawah untuk booking jadwal.",
          style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 16),
        ),
      ],
    ).animate().slideY(begin: 0.2, duration: const Duration(milliseconds: 400), curve: Curves.easeOut);
  }
  
  Widget _buildFormCard({required String title, required IconData icon, required List<Widget> fields}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withOpacity(0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(icon, color: Colors.white, size: 24),
                  const SizedBox(width: 12),
                  Text(title, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),
              const Divider(color: Colors.white30, height: 24),
              ...fields,
            ],
          ),
        ),
      ),
    ).animate(delay: const Duration(milliseconds: 200)).slideX(begin: -0.2);
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.white70),
          hintText: hint,
          hintStyle: TextStyle(color: Colors.white.withOpacity(0.4)),
          prefixIcon: Icon(icon, color: Colors.white70),
          filled: true,
          fillColor: Colors.white.withOpacity(0.1),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.white.withOpacity(0.2))),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: widget.darkMode ? AppColors.accentDark : Colors.white)),
        ),
        validator: (value) => value!.isEmpty ? '$label tidak boleh kosong' : null,
      ),
    );
  }

  Widget _buildServiceTypeSelector() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Jenis Servis', style: TextStyle(color: Colors.white70, fontSize: 16)),
          const SizedBox(height: 10),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: serviceTypes.map((type) {
              final isSelected = selectedService == type;
              final Color selectedChipColor = widget.darkMode ? AppColors.accentDark : Colors.white;
              final Color unselectedChipColor = widget.darkMode ? Colors.white.withOpacity(0.1) : Colors.white.withOpacity(0.7);
              final Color selectedTextColor = widget.darkMode ? Colors.black : AppColors.primaryLight;
              final Color unselectedTextColor = widget.darkMode ? Colors.white : AppColors.primaryLight;

              return ChoiceChip(
                label: Text(type),
                selected: isSelected,
                onSelected: (selected) {
                  setState(() {
                    selectedService = selected ? type : null;
                  });
                },
                backgroundColor: unselectedChipColor,
                selectedColor: selectedChipColor,
                labelStyle: TextStyle(color: isSelected ? selectedTextColor : unselectedTextColor, fontWeight: FontWeight.bold),
                shape: StadiumBorder(side: BorderSide(color: widget.darkMode ? Colors.white.withOpacity(0.3) : Colors.transparent)),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              );
            }).toList(),
          ),
          if (selectedService == null && _isFormSubmitted)
            const Padding(
              padding: EdgeInsets.only(top: 8.0, left: 12),
              child: Text('Pilih jenis servis', style: TextStyle(color: Colors.redAccent, fontSize: 12)),
            )
        ],
      ),
    );
  }

  Widget _buildDatePickerField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: tanggalController,
        readOnly: true,
        style: const TextStyle(color: Colors.white),
        onTap: () async {
          final pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime(2030),
          );
          if (pickedDate != null) {
            setState(() {
              tanggalController.text = '${pickedDate.day}/${pickedDate.month}/${pickedDate.year}';
            });
          }
        },
        decoration: InputDecoration(
          labelText: 'Tanggal Servis',
          labelStyle: const TextStyle(color: Colors.white70),
          hintText: 'Pilih tanggal',
          hintStyle: TextStyle(color: Colors.white.withOpacity(0.4)),
          prefixIcon: const Icon(Icons.calendar_today_outlined, color: Colors.white70),
          filled: true,
          fillColor: Colors.white.withOpacity(0.1),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.white.withOpacity(0.2))),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: widget.darkMode ? AppColors.accentDark : Colors.white)),
        ),
        validator: (value) => value!.isEmpty ? 'Tanggal wajib dipilih' : null,
      ),
    );
  }

  Widget _buildDealerDropdown() {
    return DropdownButtonFormField<String>(
      value: selectedDealer,
      items: dealerList.map((dealer) => DropdownMenuItem(value: dealer, child: Text(dealer))).toList(),
      onChanged: (value) => setState(() => selectedDealer = value),
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        labelText: 'Pilih Dealer',
        labelStyle: const TextStyle(color: Colors.white70),
        hintText: 'Pilih dealer terdekat',
        prefixIcon: const Icon(Icons.store_mall_directory_outlined, color: Colors.white70),
        filled: true,
        fillColor: Colors.white.withOpacity(0.1),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.white.withOpacity(0.2))),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: widget.darkMode ? AppColors.accentDark : Colors.white)),
      ),
      dropdownColor: widget.darkMode ? const Color(0xFF1E293B) : Colors.white,
      iconEnabledColor: Colors.white70,
      validator: (value) => value == null ? 'Dealer harus dipilih' : null,
      selectedItemBuilder: (BuildContext context) {
        return dealerList.map<Widget>((String item) {
          return Text(item, style: const TextStyle(color: Colors.white));
        }).toList();
      },
    );
  }

  Widget _buildAgreement() {
    return Row(
      children: [
        Checkbox(
          value: isAgree,
          onChanged: (value) => setState(() => isAgree = value!),
          activeColor: widget.darkMode ? AppColors.accentDark : Colors.white,
          checkColor: widget.darkMode ? Colors.black : AppColors.accentLight,
          side: const BorderSide(color: Colors.white70),
        ),
        const Expanded(child: Text('Saya menyetujui kebijakan dan ketentuan yang berlaku.', style: TextStyle(color: Colors.white70))),
      ],
    );
  }

  Widget _buildSubmitButton() {
    return Center(
      child: ElevatedButton.icon(
        icon: const Icon(Icons.send_rounded, color: Colors.white),
        label: const Text('Booking Sekarang', style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold)),
        onPressed: _submitForm,
        style: ElevatedButton.styleFrom(
          backgroundColor: widget.darkMode ? AppColors.accentDark : AppColors.accentLight,
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          elevation: 8,
          shadowColor: Colors.black.withOpacity(0.4),
        ),
      ),
    ).animate(delay: const Duration(milliseconds: 400)).slideY(begin: 0.5);
  }
}