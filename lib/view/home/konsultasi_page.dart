import 'package:flutter/material.dart';
import 'package:heartsnap/common/color_extension.dart';

class KonsultasiPage extends StatefulWidget {
  const KonsultasiPage({super.key});

  @override
  State<KonsultasiPage> createState() => _KonsultasiPageState();
}

class _KonsultasiPageState extends State<KonsultasiPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          "Konsultasi",
          style: TextStyle(
            color: TColor.primaryColor1,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          Padding(padding: EdgeInsetsGeometry.only(right: 16),
          child: Image.asset('assets/img/lonceng.png',
          height: 30,
          ),
          )
        ],
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 12),
              child: Container(
                width: 360,
                height: 36,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.black,
                    width: 2
                  )
                ),
                child: 
                Row(
                  children: [
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: 
                    Image.asset('assets/img/icon_search.png')
                    ),
                    SizedBox(width: 8,),
                    Text('Cari Dokter', style: TextStyle(
                      color: Colors.grey
                    ),)
                  ],
                ),
              ),
            ),
            SizedBox(height:12,),
            Container(
              width: 361,
              height: 104,
              decoration: 
              BoxDecoration(
                color: Color(0xFFFBF0D8),
                borderRadius: BorderRadius.circular(12)
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 12, top: 12, bottom: 12),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: AssetImage('assets/img/drnadia.png')
                        ),
                        SizedBox(width: 15,),
                        Padding(
                          padding: const EdgeInsets.only(top: 8, bottom: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Dr. Nadia',
                              style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                              ),
                              ),
                              SizedBox(height: 8,),
                              Container(
                                width: 64,
                                height: 12,
                                decoration: BoxDecoration(
                                  color: Color(0xFF739AB9),
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 1
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    "Jantung",
                                    style: TextStyle(
                                      fontSize: 8
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 8,),
                              Text('Konsultasi 15k/ Jam',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF739AB9)
                              ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 24,),
                        Align(
                          alignment: AlignmentGeometry.bottomRight,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 6),
                            child: Container(
                              width: 100,
                              height: 26,
                              decoration: BoxDecoration(
                                color: Color(0xFF113047),
                                borderRadius: BorderRadius.circular(8)
                              ),
                              child: Center(
                                child: Text(
                                  "Kontak",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
            ),
            SizedBox(height:12,),
            Container(
              width: 361,
              height: 104,
              decoration: 
              BoxDecoration(
                color: Color(0xFFFBF0D8),
                borderRadius: BorderRadius.circular(12)
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 12, top: 12, bottom: 12),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: AssetImage('assets/img/drayudia.png')
                        ),
                        SizedBox(width: 15,),
                        Padding(
                          padding: const EdgeInsets.only(top: 8, bottom: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Dr. Ayudia',
                              style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                              ),
                              ),
                              SizedBox(height: 8,),
                              Container(
                                width: 64,
                                height: 12,
                                decoration: BoxDecoration(
                                  color: Color(0xFF739AB9),
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 1
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    "Jantung",
                                    style: TextStyle(
                                      fontSize: 8
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 8,),
                              Text('Konsultasi 15k/ Jam',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF739AB9)
                              ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 24,),
                        Align(
                          alignment: AlignmentGeometry.bottomRight,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 6),
                            child: Container(
                              width: 100,
                              height: 26,
                              decoration: BoxDecoration(
                                color: Color(0xFF113047),
                                borderRadius: BorderRadius.circular(8)
                              ),
                              child: Center(
                                child: Text(
                                  "Kontak",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
            ),
            SizedBox(height:12,),
            Container(
              width: 361,
              height: 104,
              decoration: 
              BoxDecoration(
                color: Color(0xFFFBF0D8),
                borderRadius: BorderRadius.circular(12)
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 12, top: 12, bottom: 12),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: AssetImage('assets/img/drsteven.png')
                        ),
                        SizedBox(width: 15,),
                        Padding(
                          padding: const EdgeInsets.only(top: 8, bottom: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Dr. Steven',
                              style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                              ),
                              ),
                              SizedBox(height: 8,),
                              Container(
                                width: 64,
                                height: 12,
                                decoration: BoxDecoration(
                                  color: Color(0xFF739AB9),
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 1
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    "Jantung",
                                    style: TextStyle(
                                      fontSize: 8
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 8,),
                              Text('Konsultasi 15k/ Jam',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF739AB9)
                              ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 24,),
                        Align(
                          alignment: AlignmentGeometry.bottomRight,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 6),
                            child: Container(
                              width: 100,
                              height: 26,
                              decoration: BoxDecoration(
                                color: Color(0xFF113047),
                                borderRadius: BorderRadius.circular(8)
                              ),
                              child: Center(
                                child: Text(
                                  "Kontak",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
            ),
            SizedBox(height:12,),
            Container(
              width: 361,
              height: 104,
              decoration: 
              BoxDecoration(
                color: Color(0xFFFBF0D8),
                borderRadius: BorderRadius.circular(12)
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 12, top: 12, bottom: 12),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: AssetImage('assets/img/drjonatan.png')
                        ),
                        SizedBox(width: 15,),
                        Padding(
                          padding: const EdgeInsets.only(top: 8, bottom: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Dr. Jonatan',
                              style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                              ),
                              ),
                              SizedBox(height: 8,),
                              Container(
                                width: 64,
                                height: 12,
                                decoration: BoxDecoration(
                                  color: Color(0xFF739AB9),
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 1
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    "Jantung",
                                    style: TextStyle(
                                      fontSize: 8
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 8,),
                              Text('Konsultasi 15k/ Jam',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF739AB9)
                              ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 24,),
                        Align(
                          alignment: AlignmentGeometry.bottomRight,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 6),
                            child: Container(
                              width: 100,
                              height: 26,
                              decoration: BoxDecoration(
                                color: Color(0xFF113047),
                                borderRadius: BorderRadius.circular(8)
                              ),
                              child: Center(
                                child: Text(
                                  "Kontak",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
            ),
            SizedBox(height:12,),
            Container(
              width: 361,
              height: 104,
              decoration: 
              BoxDecoration(
                color: Color(0xFFFBF0D8),
                borderRadius: BorderRadius.circular(12)
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 12, top: 12, bottom: 12),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: AssetImage('assets/img/drsofia.png')
                        ),
                        SizedBox(width: 15,),
                        Padding(
                          padding: const EdgeInsets.only(top: 8, bottom: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Dr. Sofia',
                              style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                              ),
                              ),
                              SizedBox(height: 8,),
                              Container(
                                width: 64,
                                height: 12,
                                decoration: BoxDecoration(
                                  color: Color(0xFF739AB9),
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 1
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    "Jantung",
                                    style: TextStyle(
                                      fontSize: 8
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 8,),
                              Text('Konsultasi 15k/ Jam',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF739AB9)
                              ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 24,),
                        Align(
                          alignment: AlignmentGeometry.bottomRight,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 6),
                            child: Container(
                              width: 100,
                              height: 26,
                              decoration: BoxDecoration(
                                color: Color(0xFF113047),
                                borderRadius: BorderRadius.circular(8)
                              ),
                              child: Center(
                                child: Text(
                                  "Kontak",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
            ),
          ],
        ),
      ),
    );
  }
}