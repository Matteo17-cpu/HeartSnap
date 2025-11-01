import 'package:flutter/material.dart';

class PenjelasanPage extends StatelessWidget {
  const PenjelasanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          // App Bar dengan Image Hero
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            backgroundColor: Colors.white,
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: IconButton(
                  icon: Icon(Icons.arrow_back, color: Color(0xFF6D120B)),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    'assets/img/jantungkoroner2.png',
                    fit: BoxFit.cover,
                  ),
                  // Gradient overlay
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.white,
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category Badge
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Color(0xFFB7FFB0),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'Dewasa',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),

                  // Title
                  Text(
                    'Mengenal Penyakit Jantung Koroner, Penyebab Kematian Tertinggi di Dunia',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                      height: 1.3,
                    ),
                  ),
                  SizedBox(height: 8),

                  // Meta Info
                  Row(
                    children: [
                      Icon(Icons.access_time, size: 16, color: Colors.grey[600]),
                      SizedBox(width: 4),
                      Text(
                        '5 menit baca',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(width: 16),
                      Icon(Icons.calendar_today, size: 16, color: Colors.grey[600]),
                      SizedBox(width: 4),
                      Text(
                        '1 Nov 2024',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24),

                  // Divider
                  Divider(thickness: 1, color: Colors.grey[300]),
                  SizedBox(height: 24),

                  // Section 1
                  _buildSectionTitle("Apa itu Jantung Koroner?"),
                  SizedBox(height: 16),
                  _buildContentText(
                    "Salah satu penyakit kardiovaskular yang menyebabkan tingginya tingkat kematian di dunia ialah penyakit jantung koroner. Berdasarkan data Organisasi Kesehatan Dunia (WHO), 85% kematian di dunia disebabkan oleh stroke dan serangan jantung yang rentan terjadi pada laki-laki usia > 45 tahun dan wanita > 50 tahun.\n\nPenyakit jantung koroner (PJK) sendiri adalah kondisi ketika pembuluh darah jantung (arteri koroner) tersumbat oleh timbunan lemak atau substansi lainnya seperti kalsium dan fibrin yang dikenal pula dengan istilah aterosklerosis. Bila zat-zat tersebut semakin menumpuk, maka arteri akan makin menyempit dan membuat aliran darah ke jantung menjadi terhambat sehingga dapat menyebabkan gangguan irama jantung, gagal jantung, hingga kematian mendadak.",
                  ),
                  SizedBox(height: 32),

                  // Info Box
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Color(0xFFFFF8F0),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Color(0xFFFFB800).withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: Color(0xFFFFB800),
                          size: 24,
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Penyakit jantung koroner adalah penyebab kematian nomor 1 di dunia',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.black87,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 32),

                  // Section 2
                  _buildSectionTitle("Penyebab Jantung Koroner"),
                  SizedBox(height: 16),
                  _buildContentText(
                    "Sejauh ini, penyebab pasti terbentuknya plak pada pembuluh arteri masih belum diketahui secara pasti. Namun, beberapa hal berikut ini bisa memperbesar risiko terjadinya aterosklerosis atau penumpukan plak yang mempersempit pembuluh darah:",
                  ),
                  SizedBox(height: 16),

                  // Risk Factors List
                  _buildRiskFactorItem(
                    Icons.favorite,
                    "Tekanan Darah Tinggi",
                    "Hipertensi dapat merusak dinding arteri",
                    Color(0xFFE91A18),
                  ),
                  _buildRiskFactorItem(
                    Icons.water_drop,
                    "Kolesterol Tinggi",
                    "Penumpukan lemak di pembuluh darah",
                    Color(0xFFFFB800),
                  ),
                  _buildRiskFactorItem(
                    Icons.medication,
                    "Diabetes",
                    "Kadar gula darah tinggi merusak pembuluh darah",
                    Color(0xFF4CAF50),
                  ),
                  _buildRiskFactorItem(
                    Icons.smoking_rooms,
                    "Kebiasaan Merokok",
                    "Merusak lapisan pembuluh darah",
                    Color(0xFF9E9E9E),
                  ),
                  _buildRiskFactorItem(
                    Icons.bloodtype,
                    "Penggumpalan Darah",
                    "Dapat menyumbat aliran darah ke jantung",
                    Color(0xFF113047),
                  ),

                  SizedBox(height: 32),

                  // Call to Action
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF6D120B),
                          Color(0xFF6D120B).withOpacity(0.8),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFF6D120B).withOpacity(0.3),
                          blurRadius: 12,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.medical_services,
                          color: Colors.white,
                          size: 32,
                        ),
                        SizedBox(height: 12),
                        Text(
                          'Deteksi Dini Penting!',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Lakukan pemeriksaan kesehatan jantung secara rutin untuk mencegah risiko penyakit jantung koroner',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.white.withOpacity(0.9),
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 24,
          decoration: BoxDecoration(
            color: Color(0xFF6D120B),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContentText(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 14,
        color: Colors.black87,
        height: 1.6,
      ),
      textAlign: TextAlign.justify,
    );
  }

  Widget _buildRiskFactorItem(
    IconData icon,
    String title,
    String description,
    Color color,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: color,
              size: 24,
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}