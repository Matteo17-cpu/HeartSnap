import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:heartsnap/common/color_extension.dart';
import 'package:heartsnap/models/scan_history_model.dart';
import 'package:heartsnap/view/home/detection_result_page.dart';
import 'package:heartsnap/view/home/komunitas.dart';
import 'package:heartsnap/view/home/konsultasi_page.dart';
import 'package:heartsnap/view/home/obatobatan_page.dart';
import 'package:heartsnap/view/home/penjelasan_page.dart';
import 'package:heartsnap/view/home/penjelasan_page2.dart';
import 'package:heartsnap/view/home/profile_page.dart';
import 'package:heartsnap/view/home/riwayat_scan_page.dart';
import 'package:heartsnap/view/home/catatan_gejala_page.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:heartsnap/view/home/camera_scanner_page.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  AnimationController? _fabAnimationController;
  Animation<double>? _fabAnimation;
  final PageController _pageController = PageController();
  User? currentUser;
  String userName = "User";
  
  // Dynamic data
  int totalScans = 0;
  String lastScanResult = "Belum Scan";
  String lastScanTime = "Belum ada data";
  String todaySymptom = "Belum dicatat";
  bool isLoadingData = true;

  @override
  void initState() {
    super.initState();
    _fabAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fabAnimation = CurvedAnimation(
      parent: _fabAnimationController!,
      curve: Curves.easeInOut,
    );
    _fabAnimationController!.forward();
    
    // Get current user data
    currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      setState(() {
        // Prioritas: displayName > email username > "User"
        if (currentUser!.displayName != null && currentUser!.displayName!.isNotEmpty) {
          userName = currentUser!.displayName!;
        } else if (currentUser!.email != null) {
          // Ambil username dari email (sebelum @)
          userName = currentUser!.email!.split('@')[0];
        }
      });
    }
    
    // Load dynamic data
    _loadDashboardData();
  }

  Future<void> _loadDashboardData() async {
    setState(() => isLoadingData = true);
    
    try {
      final prefs = await SharedPreferences.getInstance();
      
      // Load scan history count
      final scanHistoryJson = prefs.getStringList('scan_history_list') ?? [];
      
      // Load gejala today
      final gejalaListJson = prefs.getStringList('gejala_list') ?? [];
      
      // Get latest scan
      String latestResult = "Belum Scan";
      String latestTime = "Belum ada data";
      
      if (scanHistoryJson.isNotEmpty) {
        final latestScan = ScanHistory.fromJson(
          jsonDecode(scanHistoryJson.first),
        );
        latestResult = latestScan.result;
        latestTime = _getTimeDifference(latestScan.scanDate);
      }
      
      // Get today's symptom
      String symptomToday = "Tidak ada keluhan";
      if (gejalaListJson.isNotEmpty) {
        final latestGejala = GejalaEntry.fromJson(
          jsonDecode(gejalaListJson.first),
        );
        
        // Check if it's today
        final today = DateTime.now();
        if (latestGejala.timestamp.day == today.day &&
            latestGejala.timestamp.month == today.month &&
            latestGejala.timestamp.year == today.year) {
          if (latestGejala.gejalaList.contains('Tidak Ada Keluhan')) {
            symptomToday = "Tidak ada keluhan";
          } else {
            symptomToday = "${latestGejala.gejalaList.length} gejala";
          }
        } else {
          symptomToday = "Belum dicatat";
        }
      }
      
      // Get current month scan count
      int monthlyScans = 0;
      final now = DateTime.now();
      for (var jsonStr in scanHistoryJson) {
        final scan = ScanHistory.fromJson(jsonDecode(jsonStr));
        if (scan.scanDate.month == now.month && 
            scan.scanDate.year == now.year) {
          monthlyScans++;
        }
      }
      
      setState(() {
        totalScans = monthlyScans;
        lastScanResult = latestResult;
        lastScanTime = latestTime;
        todaySymptom = symptomToday;
        isLoadingData = false;
      });
    } catch (e) {
      print('Error loading dashboard data: $e');
      setState(() => isLoadingData = false);
    }
  }

  String _getTimeDifference(DateTime scanDate) {
    final now = DateTime.now();
    final difference = now.difference(scanDate);
    
    if (difference.inMinutes < 60) {
      return '${difference.inMinutes} menit lalu';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} jam lalu';
    } else if (difference.inDays == 1) {
      return 'Kemarin';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} hari lalu';
    } else if (difference.inDays < 30) {
      return '${difference.inDays ~/ 7} minggu lalu';
    } else {
      return '${difference.inDays ~/ 30} bulan lalu';
    }
  }

  @override
  void dispose() {
    _fabAnimationController?.dispose();
    _pageController.dispose();
    super.dispose();
  }

  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage(ImageSource imageSource) async {
  // Tidak lagi digunakan, langsung buka CameraScannerPage
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const CameraScannerPage(),
    ),
  ).then((_) {
    // Refresh dashboard when returning
    _loadDashboardData();
  });
}


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOutCubic,
    );
  }
  Color _getScanResultColor() {
  if (lastScanResult.toLowerCase().contains('sehat') || 
      lastScanResult.toLowerCase().contains('normal')) {
    return const Color(0xFF00AD06); // Hijau
  } else if (lastScanResult.toLowerCase().contains('risiko rendah') || 
             lastScanResult.toLowerCase().contains('rendah')) {
    return const Color(0xFFFFB800); // Kuning
  } else if (lastScanResult.toLowerCase().contains('risiko tinggi') || 
             lastScanResult.toLowerCase().contains('tinggi') ||
             lastScanResult.toLowerCase().contains('bahaya')) {
    return const Color(0xFFE91A18); // Merah
  }
  return const Color(0xFF9E9E9E); // Abu-abu (default)
}

IconData _getScanResultIcon() {
  if (lastScanResult.toLowerCase().contains('sehat') || 
      lastScanResult.toLowerCase().contains('normal')) {
    return Icons.favorite; // Heart
  } else if (lastScanResult.toLowerCase().contains('risiko rendah') || 
             lastScanResult.toLowerCase().contains('rendah')) {
    return Icons.warning_amber; // Warning
  } else if (lastScanResult.toLowerCase().contains('risiko tinggi') || 
             lastScanResult.toLowerCase().contains('tinggi') ||
             lastScanResult.toLowerCase().contains('bahaya')) {
    return Icons.error; // Error
  }
  return Icons.help_outline; // Question (default)
}

String _getScanResultDisplay() {
  if (lastScanResult == "Belum Scan") {
    return "Belum Scan";
  }
  // Tampilkan hasil asli dari scan
  return lastScanResult;
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: _buildAppBar(),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: [
          _buildHomePage(),
          _buildKomunitasPage(),
          _buildBuletinPage(),
          _buildProfilePage(),
          
        ],
      ),
      extendBody: true,
      floatingActionButton: _fabAnimation != null
          ? ScaleTransition(
              scale: _fabAnimation!,
              child: FloatingActionButton(
                elevation: 8,
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const CameraScannerPage(),
                  ),
                  ).then((_) {
                    _loadDashboardData();
                  });
                },
                backgroundColor: TColor.primaryColor1,
                child: Image.asset(
                  'assets/img/scan.png',
                  width: 30,
                  height: 30,
                ),
              ),
            )
          : FloatingActionButton(
              elevation: 8,
              onPressed: () {
                Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CameraScannerPage(),
            ),
          ).then((_) {
            _loadDashboardData(); // Refresh data
          });
              },
              backgroundColor: TColor.primaryColor1,
              child: Image.asset(
                'assets/img/scan.png',
                width: 30,
                height: 30,
              ),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        elevation: 20,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        height: 65,
        shadowColor: Colors.black,
        color: Colors.white,
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _buildNavItem(
              'assets/img/homeicon.png',
              'Home',
              0,
            ),
            _buildNavItem(
              'assets/img/komunitasikon.png',
              'Komunitas',
              1,
            ),
            const SizedBox(width: 40),
            _buildNavItem(
              'assets/img/buletinicon.png',
              'Buletin',
              2,
            ),
            _buildNavItem(
              'assets/img/akunicon.png',
              'Akun',
              3,
            ),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    // Different app bar for different pages
    if (_selectedIndex == 1 || _selectedIndex == 2 || _selectedIndex == 3) {
      return AppBar(
        centerTitle: false,
        elevation: 0,
        title: Text(
          'Hello, $userName!',
          style: TextStyle(
            color: TColor.primaryColor1,
            fontWeight: FontWeight.w700,
            fontSize: 24,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: IconButton(
                icon: Image.asset(
                  'assets/img/lonceng.png',
                  height: 24,
                ),
                onPressed: () {},
              ),
            ),
          )
        ],
        backgroundColor: _selectedIndex == 3 ? const Color(0xFFFFF8F0) : Colors.grey[50],
      );
    }

    return AppBar(
      centerTitle: false,
      elevation: 0,
      title: Text(
        'Hello, $userName!',
        style: TextStyle(
          color: TColor.primaryColor1,
          fontWeight: FontWeight.w700,
          fontSize: 24,
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: IconButton(
              icon: Image.asset(
                'assets/img/lonceng.png',
                height: 24,
              ),
              onPressed: () {},
            ),
          ),
        )
      ],
      backgroundColor: Colors.grey[50],
    );
  }

  Widget _buildHomePage() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.only(top: 8, left: 16, right: 16, bottom: 90),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Card
            Hero(
              tag: 'main_card',
              child: Material(
                color: Colors.transparent,
                child: Container(
                  width: double.infinity,
                  height: 180,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        TColor.primaryColor1,
                        TColor.primaryColor1.withOpacity(0.8),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: TColor.primaryColor1.withOpacity(0.3),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 0,
                        left: 0,
                        child: Opacity(
                          opacity: 0.5,
                          child: Image.asset("assets/img/eclipse1.png"),
                        ),
                      ),
                      Positioned(
                        top: 20,
                        left: 20,
                        child: SizedBox(
                          width: 90,
                          height: 85,
                          child: Image.asset("assets/img/OBJECTS.png"),
                        ),
                      ),
                      Positioned(
                        top: 32,
                        right: 20,
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const CameraScannerPage(),
    ),
  ).then((_) {
    _loadDashboardData(); // refresh dashboard setelah kembali dari kamera
  });
                            },
                            borderRadius: BorderRadius.circular(12),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                gradient: const LinearGradient(
                                  colors: [Color(0xFFEA1A19), Color(0xFFB30403)],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 8,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  Text(
                                    'Ukur Sekarang',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Color(0xFFFEFDF9),
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: Color(0xFFFEFDF9),
                                    size: 14,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 20,
                        left: 20,
                        right: 20,
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {},
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white.withOpacity(0.2),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.3),
                                  width: 1,
                                ),
                              ),
                              child: Row(
                                children: const [
                                  Text(
                                    'Catatan Terakhir',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFFFEFDF9),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    'Riwayat',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFFFEFDF9),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(width: 4),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: Color(0xFFFEFDF9),
                                    size: 12,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            
            // Section Header
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: TColor.primaryColor1.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Image.asset(
                    'assets/img/buletinicon.png',
                    width: 20,
                    height: 20,
                    color: TColor.primaryColor1,
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  "Informasi Kesehatan",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    _onItemTapped(2); // Go to Buletin page
                  },
                  child: Text(
                    "Lihat Semua",
                    style: TextStyle(
                      fontSize: 13,
                      color: TColor.primaryColor1,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            
            // Info Card
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFFBF0D8),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      'assets/img/penyakitjantung.png',
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFB7FFB0),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            'Dewasa',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Mengenal Penyakit Jantung Koroner,\nPenyebab Kematian Tertinggi di Dunia',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            height: 1.3,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            
            // Monitoring Kesehatan Section
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: TColor.primaryColor1.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.monitor_heart,
                    size: 20,
                    color: TColor.primaryColor1,
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  "Monitoring Kesehatan",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // New Feature Grid
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
  child: isLoadingData
      ? Container(
          height: 140,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        )
      : _buildHealthCard(
          title: "Hasil Scan\nTerakhir",
          icon: _getScanResultIcon(),
          color: _getScanResultColor(),
          value: _getScanResultDisplay(),
          subtitle: lastScanTime,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const RiwayatScanPage(),
              ),
            );
          },
        ),
),
                    const SizedBox(width: 12),
                    Expanded(
  child: isLoadingData
      ? Container(
          height: 140,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        )
      : _buildHealthCard(
          title: "Total\nPemeriksaan",
          icon: Icons.assessment,
          color: const Color(0xFF113047),
          value: "${totalScans}x",
          subtitle: "Bulan ini",
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const RiwayatScanPage(),
              ),
            );
          },
        ),
),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
  child: isLoadingData
      ? Container(
          height: 140,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        )
      : _buildHealthCard(
          title: "Catatan\nGejala",
          icon: Icons.note_alt,
          color: const Color(0xFFFFB800),
          value: todaySymptom == "Tidak ada keluhan" ? "Tidak Ada" : todaySymptom,
          subtitle: "Hari ini",
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CatatanGejalaPage(),
              ),
            );
          },
        ),
),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildHealthCard(
                        title: "Konsultasi\nDokter",
                        icon: Icons.medical_services,
                        color: const Color(0xFFE91A18),
                        value: "Jadwal",
                        subtitle: "Buat janji",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => KonsultasiPage(),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Quick Access Section
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: TColor.primaryColor1.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.apps,
                    size: 20,
                    color: TColor.primaryColor1,
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  "Fitur Lainnya",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Additional Features
            Row(
              children: [
                Expanded(
                  child: _buildQuickAccessCard(
                    icon: Icons.medication,
                    title: "Obat-obatan",
                    subtitle: "Info obat jantung",
                    color: const Color(0xFF4CAF50),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ObatobatanPage(),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildQuickAccessCard(
                    icon: Icons.article,
                    title: "Artikel",
                    subtitle: "Tips kesehatan",
                    color: const Color(0xFF2196F3),
                    onTap: () {
                      _onItemTapped(2); // Go to Buletin
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Update method _buildKomunitasPage() dan _buildBuletinPage() di Dashboard
// Ganti kedua method ini di file dashboard.dart Anda

Widget _buildKomunitasPage() {
  return ListView.builder(
    padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 90),
    itemCount: 6,
    itemBuilder: (context, index) {
      return _buildPostCard();
    },
  );
}

Widget _buildPostCard() {
  return Container(
    margin: const EdgeInsets.only(bottom: 16),
    decoration: BoxDecoration(
      color: Color(0xFFEDE6F0),
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.04),
          blurRadius: 8,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage('assets/img/Avatar.png'),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Header",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      "Subhead",
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Image.asset('assets/img/icon1.png', height: 20),
                onPressed: () {},
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(),
              ),
            ],
          ),
        ),
        
        // Image
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Image.asset(
              'assets/img/postkomunitas.png',
              width: double.infinity,
              height: 180,
              fit: BoxFit.cover,
            ),
          ),
        ),
        
        // Content
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Title',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Subtitle',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
              SizedBox(height: 12),
              Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  height: 1.4,
                ),
              ),
              SizedBox(height: 12),
              Image.asset('assets/img/icon2.png', height: 24),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildBuletinPage() {
  int selectedCategory = 0;
  final List<String> categories = ['Semua', 'Dewasa', 'Remaja', 'Anak-anak', 'Bayi'];
  
  return SingleChildScrollView(
    physics: const BouncingScrollPhysics(),
    child: Padding(
      padding: const EdgeInsets.only(bottom: 90),
      child: Column(
        children: [
          // Info Banner
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Color(0xFFFBF0D8),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    'assets/img/penyakitjantung.png',
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Text(
                    'Temukan informasi-informasi terbaru terkait dunia kesehatan di sini!',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade300, width: 1.5),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Image.asset(
                      'assets/img/icon_search.png',
                      width: 20,
                      height: 20,
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Cari Artikel',
                        hintStyle: TextStyle(
                          color: Colors.grey.shade400,
                          fontSize: 14,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Section Title
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
            child: Row(
              children: [
                Image.asset(
                  'assets/img/buletinicon.png',
                  width: 24,
                  height: 24,
                  color: TColor.black,
                ),
                SizedBox(width: 12),
                Text(
                  "Buletin Terbaru",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),

          // Category Pills
          Container(
            height: 40,
            margin: const EdgeInsets.only(bottom: 16),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final isSelected = selectedCategory == index;
                return Container(
                  margin: const EdgeInsets.only(right: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  decoration: BoxDecoration(
                    color: isSelected ? Color(0xFF113047) : Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isSelected ? Color(0xFF113047) : Colors.red,
                      width: 1.5,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      categories[index],
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.red,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Articles List
          _buildArticleCardList(context, 'assets/img/penyakitjantung.png', 
            'Mengenal Penyakit Jantung Koroner, Penyebab Kematian Tertinggi di Dunia', 
            PenjelasanPage()),
          _buildArticleCardList(context, 'assets/img/buletin2.png',
            'Kadar HDL Tinggi Bisa Meningkatkan Risiko Penyakit Kardiovaskular',
            PenjelasanPage2()),
          _buildArticleCardList(context, 'assets/img/penyakitjantung.png',
            'Mengenal Penyakit Jantung Koroner, Penyebab Kematian Tertinggi di Dunia',
            PenjelasanPage()),
          _buildArticleCardList(context, 'assets/img/buletin2.png',
            'Kadar HDL Tinggi Bisa Meningkatkan Risiko Penyakit Kardiovaskular',
            PenjelasanPage2()),
          _buildArticleCardList(context, 'assets/img/penyakitjantung.png',
            'Mengenal Penyakit Jantung Koroner, Penyebab Kematian Tertinggi di Dunia',
            PenjelasanPage()),
          _buildArticleCardList(context, 'assets/img/buletin2.png',
            'Kadar HDL Tinggi Bisa Meningkatkan Risiko Penyakit Kardiovaskular',
            PenjelasanPage2()),
        ],
      ),
    ),
  );
}

Widget _buildArticleCardList(BuildContext context, String imagePath, String title, Widget destination) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => destination),
      );
    },
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Color(0xFFFBF0D8),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              imagePath,
              width: 70,
              height: 70,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: Color(0xFFB7FFB0),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Dewasa',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                    height: 1.3,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

  Widget _buildProfilePage() {
    return const ProfilePage();
  }

  Widget _buildFilterChip(String label, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF113047) : Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: isSelected ? null : Border.all(color: Colors.red, width: 1),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.red,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _buildBuletinItem(Widget destination, String imageName, String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, left: 8, right: 8),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => destination),
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
          decoration: BoxDecoration(
            color: const Color(0xFFFBF0D8),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  'assets/img/$imageName',
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFB7FFB0),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Text(
                        'Dewasa',
                        style: TextStyle(
                          fontSize: 8,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        height: 1.3,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHealthCard({
    required String title,
    required IconData icon,
    required Color color,
    required String value,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        height: 140,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: color.withOpacity(0.3),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    icon,
                    color: color,
                    size: 18,
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey[400],
                  size: 12,
                ),
              ],
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[600],
                      height: 1.1,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 9,
                      color: Colors.grey[500],
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickAccessCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color,
              color.withOpacity(0.8),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: 28,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 12,
                color: Colors.white.withOpacity(0.9),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard(String imagePath) {
    return Container(
      height: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.asset(
          imagePath,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildNavItem(String iconPath, String label, int index) {
    final isSelected = _selectedIndex == index;
    return InkWell(
      onTap: () => _onItemTapped(index),
      borderRadius: BorderRadius.circular(12),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: isSelected
              ? TColor.primaryColor1.withOpacity(0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedScale(
              scale: isSelected ? 1.1 : 1.0,
              duration: const Duration(milliseconds: 300),
              child: ImageIcon(
                AssetImage(iconPath),
                size: 26,
                color: isSelected
                    ? TColor.primaryColor1
                    : const Color(0xFF6D120B).withOpacity(0.5),
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                color: isSelected
                    ? TColor.primaryColor1
                    : const Color(0xFF6D120B).withOpacity(0.5),
                fontSize: isSelected ? 12 : 11,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}