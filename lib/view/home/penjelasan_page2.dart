import 'package:flutter/material.dart';

class PenjelasanPage2 extends StatelessWidget {
  const PenjelasanPage2({super.key});

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
                    'assets/img/lipid.png',
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
                    'Kadar HDL Tinggi Bisa Meningkatkan Risiko Penyakit Kardiovaskular',
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
                        '4 menit baca',
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
                  _buildSectionTitle("Apa itu High Density Lipoprotein (HDL)?"),
                  SizedBox(height: 16),
                  _buildContentText(
                    "HDL (high density lipoprotein) adalah salah satu subfraksi dari lipoprotein. Lipoprotein adalah partikel kompleks yang terdiri dari berbagai protein yang mengangkut molekul lipid ke seluruh tubuh dengan lapisan luar bersifat hidrofilik dan inti partikel bersifat hidrofobik.\n\nAda 6 subfraksi lipoprotein yaitu chylomicrons, VLDL (very low density lipoprotein), LDL (low density lipoprotein), IDL (intermediate density lipoprotein), HDL (high density lipoprotein), dan lipoprotein-a (LpA).",
                  ),
                  SizedBox(height: 24),

                  // Info Box - Good Cholesterol
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Color(0xFFE8F5E9),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Color(0xFF4CAF50).withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.check_circle_outline,
                          color: Color(0xFF4CAF50),
                          size: 24,
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'HDL dikenal sebagai "kolesterol baik" yang membantu membersihkan kolesterol jahat',
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
                  _buildSectionTitle("Berapa Kadar Ideal HDL?"),
                  SizedBox(height: 16),
                  _buildContentText(
                    "Kadar HDL diukur dalam miligram per desiliter (mg/dL). Berikut adalah kategori kadar HDL yang umum:",
                  ),
                  SizedBox(height: 20),

                  // HDL Levels Cards
                  _buildHDLLevelCard(
                    "Rendah",
                    "< 40 mg/dL",
                    "Meningkatkan risiko penyakit jantung",
                    Color(0xFFE91A18),
                    Icons.arrow_downward,
                  ),
                  SizedBox(height: 12),
                  _buildHDLLevelCard(
                    "Normal",
                    "40-59 mg/dL",
                    "Kadar HDL dalam batas normal",
                    Color(0xFFFFB800),
                    Icons.horizontal_rule,
                  ),
                  SizedBox(height: 12),
                  _buildHDLLevelCard(
                    "Ideal",
                    "≥ 60 mg/dL",
                    "Memberikan perlindungan terhadap penyakit jantung",
                    Color(0xFF4CAF50),
                    Icons.arrow_upward,
                  ),
                  SizedBox(height: 24),

                  _buildContentText(
                    "Kadar HDL yang optimal dapat bervariasi tergantung pada usia, jenis kelamin, dan faktor risiko kesehatan lainnya. Konsultasikan dengan dokter untuk mengetahui target kadar HDL yang tepat.",
                  ),
                  SizedBox(height: 32),

                  // Warning Box
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Color(0xFFFFF3E0),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Color(0xFFFFB800).withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.warning_amber_rounded,
                              color: Color(0xFFFFB800),
                              size: 24,
                            ),
                            SizedBox(width: 12),
                            Text(
                              'Perhatian',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12),
                        Text(
                          'HDL yang terlalu tinggi (> 100 mg/dL) justru dapat meningkatkan risiko penyakit kardiovaskular. Penting untuk menjaga kadar HDL dalam rentang ideal.',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.black87,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 32),

                  // Tips Section
                  _buildSectionTitle("Tips Menjaga Kadar HDL"),
                  SizedBox(height: 16),
                  _buildTipItem(
                    Icons.directions_run,
                    "Olahraga Teratur",
                    "Minimal 30 menit setiap hari",
                  ),
                  _buildTipItem(
                    Icons.restaurant,
                    "Pola Makan Sehat",
                    "Konsumsi lemak sehat seperti ikan, kacang, dan alpukat",
                  ),
                  _buildTipItem(
                    Icons.smoking_rooms_outlined,
                    "Hindari Merokok",
                    "Merokok dapat menurunkan kadar HDL",
                  ),
                  _buildTipItem(
                    Icons.scale,
                    "Jaga Berat Badan",
                    "Pertahankan berat badan ideal",
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
                          'Periksa Kadar Kolesterol Anda',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Lakukan pemeriksaan kadar kolesterol secara rutin untuk memantau kesehatan jantung Anda',
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

  Widget _buildHDLLevelCard(
    String level,
    String range,
    String description,
    Color color,
    IconData icon,
  ) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 2,
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
              size: 28,
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      level,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(width: 8),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        range,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: color,
                        ),
                      ),
                    ),
                  ],
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

  Widget _buildTipItem(IconData icon, String title, String description) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Color(0xFF6D120B).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: Color(0xFF6D120B),
              size: 20,
            ),
          ),
          SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
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