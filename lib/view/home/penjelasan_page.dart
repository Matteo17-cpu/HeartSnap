import 'package:flutter/material.dart';

class PenjelasanPage extends StatelessWidget {
  const PenjelasanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Image.asset('assets/img/jantungkoroner2.png'),
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
                              "Apa itu jantung koroner",
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
                            "Salah satu penyakit kardiovaskular yang menyebabkan tingginya tingkat kematian di dunia ialah penyakit jantung koroner. Berdasarkan data Organisasi Kesehatan Dunia (WHO), 85% kematian di dunia disebabkan oleh stroke dan serangan jantung yang rentan terjadi pada laki-laki usia > 45 tahun dan wanita > 50 tahun. Penyakit jantung koroner (PJK) sendiri adalah kondisi ketika pembuluh darah jantung (arteri koroner) tersumbat oleh timbunan lemak atau substansi lainnya seperti kalsium dan fibrin yang dikenal pula dengan istilah aterosklerosis. Bila zat-zat tersebut semakin menumpuk, maka arteri akan makin menyempit dan membuat aliran darah ke jantung menjadi terhambat sehingga dapat menyebabkan gangguan irama jantung, gagal jantung, hingga kematian mendadak.",
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
                                    "Penyebab jantung koroner?",
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
                                  "Sejauh ini, penyebab pasti terbentuknya plak pada pembuluh arteri masih belum diketahui secara pasti. Namun, beberapa hal berikut ini bisa memperbesar risiko terjadinya aterosklerosis atau penumpukan plak yang mempersempit pembuluh darah:\n1. Tekanan darah tinggi\n2. Kolestrol\n3. Diabetes\n4. Kebiasaan Merokok\n5. Penggumpalan darah",
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
