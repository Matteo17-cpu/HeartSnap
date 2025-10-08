import 'package:flutter/material.dart';

class PenjelasanPage2 extends StatelessWidget {
  const PenjelasanPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Image.asset('assets/img/lipid.png'),
              Positioned(
                top: 156,
                left: 16,
                right: 16,
                child: Container(
                  height: 679,
                  decoration: BoxDecoration(
                    color: Color(0xFFFBF0D8),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16, top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // === BAGIAN 1 ===
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 5,
                              height: 30,
                              color: Color(0xFF6D120B),
                            ),
                            SizedBox(width: 8),
                            Text(
                              "Apa itu High Density\nLipoprotein?",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 22, right: 16, left: 16),
                          child: Text(
                            "HDL (high density lipoprotein) adalah salah satu subfraksi dari lipoprotein. Lipoprotein adalah partikel kompleks yang terdiri dari  berbagai protein yang mengangkut molekul lipid ke seluruh tubuh dengan  lapisan luar bersifat hidrofilik dan inti partikel bersifat hidrofobik.  Ada 6 subfraksi lipoprotein yaitu chylomicrons, VLDL (very low density lipoprotein), LDL (low density lipoprotein), IDL (intermediate density lipoprotein), HDL (high density lipoprotein), dan lipoprotein-a (LpA).",
                            style: TextStyle(fontSize: 12),
                          ),
                        ),

                        // === BAGIAN 2 ===
                        Padding(
                          padding: const EdgeInsets.only(left: 0, top: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 5,
                                    height: 30,
                                    color: Color(0xFF6D120B),
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    "Berapa Kadar Ideal HDL?",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 22, right: 16, left: 16),
                                child: Text(
                                  "Kadar HDL diukur dalam miligram per desiliter (mg/dL). Berikut adalah kategori kadar HDL yang umum:Rendah: Kurang dari 40 mg/dL (untuk pria dan wanita) – meningkatkan risiko penyakit jantung.Ideal: 60 mg/dL atau lebih tinggi – memberikan perlindungan terhadap penyakit jantung.Kadar HDL yang optimal dapat bervariasi tergantung pada usia, jenis kelamin, dan  faktor risiko kesehatan lainnya. Konsultasikan dengan dokter untuk  mengetahui target kadar HDL yang tepat.",
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
