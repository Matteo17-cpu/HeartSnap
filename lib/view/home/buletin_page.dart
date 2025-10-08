import 'package:flutter/material.dart';
import 'package:heartsnap/common/color_extension.dart';
import 'package:heartsnap/view/home/penjelasan_page.dart';
import 'package:heartsnap/view/home/penjelasan_page2.dart';
class BuletinPage extends StatefulWidget {
  const BuletinPage({super.key});

  @override
  State<BuletinPage> createState() => _BuletinPageState();
}

class _BuletinPageState extends State<BuletinPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
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
                              Text(
                                'Temukan informasi-informasi terbaru\nterkait dunia kesehatan di sini!',
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
              ),
              Container(
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
                    Text('Cari Artikel', style: TextStyle(
                      color: Colors.grey
                    ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, top: 12),
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
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, top: 12),
                child: SingleChildScrollView(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          width: 68,
                          height: 26,
                          decoration: BoxDecoration(
                            color: Color(0xFF113047),
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: Center(
                            child: Text(
                              "Semua", style: TextStyle(
                                color: Colors.white,
                                fontSize: 12
                              ),
                            ),
                          ),
                        ),
                      Container(
                          width: 68,
                          height: 26,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.red,
                              width: 1
                            )
                          ),
                          child: Center(
                            child: Text(
                              "Dewasa", style: TextStyle(
                                color: Colors.red,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 68,
                          height: 26,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.red,
                              width: 1
                            )
                          ),
                          child: Center(
                            child: Text(
                              "Remaja", style: TextStyle(
                                color: Colors.red,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 93,
                          height: 26,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.red,
                              width: 1
                            )
                          ),
                          child: Center(
                            child: Text(
                              "Anak-anak", style: TextStyle(
                                color: Colors.red,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 68,
                          height: 26,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.red,
                              width: 1
                            )
                          ),
                          child: Center(
                            child: Text(
                              "Bayi", style: TextStyle(
                                color: Colors.red,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => PenjelasanPage()),);
                  },
                  child: Container(
                    width: 393,
                    height: 79,
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
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => PenjelasanPage2()),);
                  },
                  child: Container(
                    width: 393,
                    height: 79,
                    padding: EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                    decoration: BoxDecoration(
                      color: Color(0xFFFBF0D8),
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                    child: Row(
                      children: [
                        Image.asset('assets/img/buletin2.png'),
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
                              'Kadar HDL Tinggi Bisa Meningkatkan Risiko\nPenyakit Kardiovaskular',
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
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => PenjelasanPage()),);
                  },
                  child: Container(
                    width: 393,
                    height: 79,
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
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => PenjelasanPage2()),);
                  },
                  child: Container(
                    width: 393,
                    height: 79,
                    padding: EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                    decoration: BoxDecoration(
                      color: Color(0xFFFBF0D8),
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                    child: Row(
                      children: [
                        Image.asset('assets/img/buletin2.png'),
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
                              'Kadar HDL Tinggi Bisa Meningkatkan Risiko\nPenyakit Kardiovaskular',
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
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => PenjelasanPage()),);
                  },
                  child: Container(
                    width: 393,
                    height: 79,
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
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => PenjelasanPage2()),);
                  },
                  child: Container(
                    width: 393,
                    height: 79,
                    padding: EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                    decoration: BoxDecoration(
                      color: Color(0xFFFBF0D8),
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                    child: Row(
                      children: [
                        Image.asset('assets/img/buletin2.png'),
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
                              'Kadar HDL Tinggi Bisa Meningkatkan Risiko\nPenyakit Kardiovaskular',
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
                ),
              ),

          ]
        ),
      ),
      )
    );
  }
}