import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Container(
                width: 393,
                height: 100,
                decoration: BoxDecoration(
                  color: Color(0xFF113047),
                  borderRadius: BorderRadius.circular(8)
                ),
                child: Column(
                  children: [
                    Align(
                      alignment: AlignmentGeometry.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20, left: 16),
                        child: Text(
                          "Verifikasi akun untuk export data",
                          style: TextStyle(
                            color: Color(0xFFFBF0D8),
                            fontSize: 10
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 12,),
                    Container(
                      width: 361,
                      height: 31,
                      decoration: BoxDecoration(
                        color: Color(0xFFE91A18),
                        borderRadius: BorderRadius.circular(8)
                      ),
                      child: Center(
                        child: Text(
                          "Verifikasi Akun", style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 22,),
              Align(
                alignment: AlignmentGeometry.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, bottom: 10),
                  child: Text(
                    "Pengaturan", style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w700
                    ),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 361,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Color(0xFFFBF0D8),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 12, top: 8, bottom: 8),
                          child: Image.asset("assets/img/profileicon1.png", width: 24, height: 24, color: Color(0xFF0B1F2D)
                          ),
                        ),
                        SizedBox(width: 8,),
                        Text("Profile", style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF0B1F2D),
                          fontWeight: FontWeight.w700
                        ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),

                  Container(
                    width: 361,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Color(0xFFFBF0D8),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 12, top: 8, bottom: 8),
                          child: Image.asset("assets/img/homeicon.png", width: 24, height: 24, color: Color(0xFF0B1F2D)
                          ),
                        ),
                        SizedBox(width: 8,),
                        Text("Riwayat", style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF0B1F2D),
                          fontWeight: FontWeight.w700
                        ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  
                  Container(
                    width: 361,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Color(0xFFFBF0D8),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 12, top: 8, bottom: 8),
                          child: Image.asset("assets/img/lonceng.png", width: 24, height: 24, color: Color(0xFF0B1F2D)
                          ),
                        ),
                        SizedBox(width: 8,),
                        Text("Notifikasi", style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF0B1F2D),
                          fontWeight: FontWeight.w700
                        ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  
                  Container(
                    width: 361,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Color(0xFFFBF0D8),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 12, top: 8, bottom: 8),
                          child: Image.asset("assets/img/languageicon.png", width: 24, height: 24, color: Color(0xFF0B1F2D)
                          ),
                        ),
                        SizedBox(width: 8,),
                        Text("Bahasa", style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF0B1F2D),
                          fontWeight: FontWeight.w700
                        ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  
                  Container(
                    width: 361,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Color(0xFFFBF0D8),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 12, top: 8, bottom: 8),
                          child: Image.asset("assets/img/exporticon.png", width: 24, height: 24, color: Color(0xFF0B1F2D)
                          ),
                        ),
                        SizedBox(width: 8,),
                        Text("Export Data", style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF0B1F2D),
                          fontWeight: FontWeight.w700
                        ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 22,),
                  Align(
                alignment: AlignmentGeometry.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, bottom: 10),
                  child: Text(
                    "Lainnya", style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w700
                    ),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 361,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Color(0xFFFBF0D8),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 12, top: 8, bottom: 8),
                          child: Image.asset("assets/img/profileicon1.png", width: 24, height: 24, color: Color(0xFF0B1F2D)
                          ),
                        ),
                        SizedBox(width: 8,),
                        Text("Beri Rating", style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF0B1F2D),
                          fontWeight: FontWeight.w700
                        ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),

                  Container(
                    width: 361,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Color(0xFFFBF0D8),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 12, top: 8, bottom: 8),
                          child: Image.asset("assets/img/privasiicon.png", width: 24, height: 24, color: Color(0xFF0B1F2D)
                          ),
                        ),
                        SizedBox(width: 8,),
                        Text("Kebijakan Privasi", style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF0B1F2D),
                          fontWeight: FontWeight.w700
                        ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  
                  Container(
                    width: 361,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Color(0xFFFBF0D8),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 12, top: 8, bottom: 8),
                          child: Image.asset("assets/img/lonceng.png", width: 24, height: 24, color: Color(0xFF0B1F2D)
                          ),
                        ),
                        SizedBox(width: 8,),
                        Text("Version", style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF0B1F2D),
                          fontWeight: FontWeight.w700
                        ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
            ]
        ),
      ),
    ));
  }
}