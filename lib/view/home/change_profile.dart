import 'package:flutter/material.dart';

class ChangeProfile extends StatefulWidget {
  const ChangeProfile({super.key});

  @override
  State<ChangeProfile> createState() => _ChangeProfileState();
}

class _ChangeProfileState extends State<ChangeProfile> {
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
                          "Profil",
                          style: TextStyle(
                            color: Color(0xFFFBF0D8),
                            fontSize: 16,
                            fontWeight: FontWeight.w700
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 12,),
                    Center(
                      child: Text("Lengkapi Profilmu", style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFFBF0D8)
                      ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 53,),
              Padding(
                padding: const EdgeInsets.only(left: 11, right: 11),
                child: Row(
                  children: [
                    Column(
                      children: [
                        CircleAvatar(
                          radius: 85,
                        ),
                        SizedBox(height: 12,),
                        Center(
                          child: Text(
                            "Laki-laki", style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(width: 20,),
                    Column(
                      children: [
                        CircleAvatar(
                          radius: 85,
                        ),
                        SizedBox(height: 12,),
                        Center(
                          child: Text(
                            "Perempuan", style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: 40,),
              Container(
                    width: 361,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Color(0xFFFBF0D8),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Text("Nama", style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold
                          ),)
                        ),
                        SizedBox(width: 8,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Text("Cristiano Situmorang", style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF0B1F2D),
                            fontWeight: FontWeight.bold
                          ),
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Text("Umur", style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold
                          ),)
                        ),
                        SizedBox(width: 8,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Text("20", style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF0B1F2D),
                            fontWeight: FontWeight.bold
                          ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 200,),
                  Container(
                    width: 361,
                    height: 52,
                    decoration: BoxDecoration(
                      color: Color(0xFF113047),
                      borderRadius: BorderRadius.circular(8)
                    ),
                    child: Center(
                      child: Text(
                        "Save", style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  )
            ]
          ),
      ),
      )
    );
  }
}