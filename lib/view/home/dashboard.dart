import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:heartsnap/common/color_extension.dart';
import 'package:heartsnap/view/home/buletin_page.dart';
import 'package:heartsnap/view/home/detection_result_page.dart';
import 'package:heartsnap/view/home/komunitas.dart';
import 'package:heartsnap/view/home/konsultasi_page.dart';
import 'package:heartsnap/view/home/obatobatan_page.dart';
import 'package:heartsnap/view/home/penjelasan_page.dart';
import 'package:heartsnap/view/home/profile_page.dart';
import 'package:image_picker/image_picker.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    Center(child: Text('Beranda')),
    Center(child: Text('Komunitas')),
    Center(child: Text('Buletin')),
    Center(child: Text('Akun')),
  ];

  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage(ImageSource imageSource) async {
    try {
      final XFile? image = await _picker.pickImage(source: imageSource);
      if (image == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No image selected')),
        );
        return;
      }
      // DETECT YOLO
      // IF
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetectionResultPage(image.path),
        ),
      );
    } on PlatformException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to pick image: ${e.message}')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Unexpected error: $e')),
      );
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          'Hello, User!',
          style: TextStyle(
            color: TColor.primaryColor1,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Image.asset(
              'assets/img/lonceng.png',
              height: 30,
            ),
          )
        ],
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 80),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 160,
                decoration: BoxDecoration(
                  color: TColor.primaryColor1,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Stack(
                  alignment: Alignment.topLeft,
                  children: [
                    Image.asset("assets/img/eclipse1.png"),
                    Positioned(
                      top: 18,
                      left: 16,
                      child: SizedBox(
                        width: 90,
                        height: 85,
                        child: Image.asset("assets/img/OBJECTS.png"),
                      ),
                    ),
                    Positioned(
                      top: 29,
                      left: 171,
                      child: Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(left: 12, right: 11),
                        width: 171,
                        height: 32,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          gradient: LinearGradient(
                            colors: [Color(0xFFEA1A19), Color(0xFFB30403)],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                        ),
                        child: Row(
                          children: [
                            Text(
                              'Ukur Sekarang',
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xFFFEFDF9),
                                fontWeight: FontWeight.w700,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Spacer(),
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Color(0xFFFEFDF9),
                              size: 13,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 100,
                      left: 80,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          color: Color(0xFF8C8C8C),
                        ),
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        width: 275,
                        height: 26,
                        child: Row(
                          children: [
                            Text(
                              'Catatan Terakhir',
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xFFFEFDF9),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Spacer(),
                            Text(
                              'Riwayat',
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xFFFEFDF9),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Color(0xFFFEFDF9),
                              size: 13,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Image.asset(
                    'assets/img/buletinicon.png',
                    width: 24,
                    height: 24,
                    color: TColor.black,
                  ),
                  SizedBox(width: 12),
                  Text(
                    "Informasi Kesehatan",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Spacer(),
                  Text(
                    "Lihat Semua",
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF739AB9),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Container(
                padding: EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                decoration: BoxDecoration(
                  color: Color(0xFFFBF0D8),
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
                child: Row(
                  children: [
                    Image.asset('assets/img/penyakitjantung.png'),
                    SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          width: 64,
                          height: 12,
                          decoration: BoxDecoration(
                            color: Color(0xFFB7FFB0),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            'Dewasa',
                            style: TextStyle(fontSize: 6),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Mengenal Penyakit Jantung Koroner,\nPenyebab Kematian Tertinggi di Dunia',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Image.asset(
                    'assets/img/catatan.png',
                    width: 24,
                    height: 24,
                    color: TColor.black,
                  ),
                  SizedBox(width: 12),
                  Text(
                    "Catatan Kesehatan",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(child: Image.asset("assets/img/fitur1.png", height: 170)),
                        Expanded(child: Image.asset("assets/img/fitur2.png", height: 170))
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(child: Image.asset("assets/img/fitur3.png", height: 170)),
                        Expanded(child: Image.asset("assets/img/fitur4.png", height: 170))
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(child: InkWell
                        (onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ObatobatanPage()));
                        },
                          child: Image.asset("assets/img/fitur5.png", height: 170))
                          ),
                        Expanded(child: InkWell
                        (onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => KonsultasiPage()));
                        },
                          child: Image.asset("assets/img/fitur6.png", height: 170))
                          ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      extendBody: true,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          pickImage(ImageSource.camera);
        },
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
        height: 60,
        shadowColor: Colors.black,
        color: Colors.cyan.shade400,
        shape: const CircularNotchedRectangle(),
        notchMargin: 5,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Scaffold(
                      body: Center(child: Text("Halaman Home")),
                    ),
                  ),
                );
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ImageIcon(
                    AssetImage('assets/img/homeicon.png'),
                    size: 35,
                    color: TColor.lightGray,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Home',
                    style: TextStyle(
                      color: TColor.lightGray,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: ImageIcon(
                AssetImage('assets/img/komunitasikon.png'),
                size: 50,
                color: TColor.lightGray,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Komunitas()),
                );
              },
            ),

            const SizedBox(width: 20),
            IconButton(
              icon: ImageIcon(
                AssetImage('assets/img/buletinicon.png'),
                size: 50,
                color: TColor.lightGray,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BuletinPage()),
                );
              },
            ),
            IconButton(
              icon: ImageIcon(
                AssetImage('assets/img/akunicon.png'),
                size: 50,
                color: TColor.lightGray,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfilePage()
                    ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
