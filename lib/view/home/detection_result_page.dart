import 'dart:io';
import 'package:flutter/material.dart';
import 'package:heartsnap/services/scan_history_services.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:image/image.dart' as image_dart;
// TAMBAHKAN IMPORT INI
import 'package:heartsnap/models/scan_history_model.dart';

class DetectionResultPage extends StatelessWidget {
  final String imagePath;

  const DetectionResultPage(this.imagePath, {super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _micropadDetect(imagePath),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            backgroundColor: const Color(0xFFFFF8F0),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF113047)),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Menganalisis gambar...",
                    style: TextStyle(
                      color: Color(0xFF113047),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            backgroundColor: const Color(0xFFFFF8F0),
            appBar: AppBar(
              backgroundColor: const Color(0xFF113047),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
              title: const Text(
                "Error",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 80,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Terjadi kesalahan:\n${snapshot.error}",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else if (snapshot.hasData) {
          final result = snapshot.data!;
          final info = _getResultInfo(result);
          final scanDate = DateTime.now();

          return Scaffold(
            backgroundColor: const Color(0xFFFFF8F0),
            appBar: AppBar(
              backgroundColor: const Color(0xFF113047),
              elevation: 2,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
                onPressed: () => Navigator.pop(context),
              ),
              title: const Text(
                "Hasil Scan",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ======== HASIL UTAMA ========
                    _buildMainResultCard(result, info, imagePath),

                    const SizedBox(height: 16),

                    // ======== DETAIL KONDISI ========
                    _buildDetailCard(info),

                    const SizedBox(height: 16),

                    // ======== SARAN EKSKLUSIF ========
                    _buildSectionCard(
                      title: "Saran Eksklusif",
                      icon: Icons.lightbulb_outline,
                      items: const [
                        _SectionItem(
                          icon: Icons.favorite,
                          title: "Pola Hidup Sehat",
                          text:
                              "Usahakan untuk tidur cukup, minum air putih yang banyak, dan olahraga ringan secara rutin.",
                        ),
                        _SectionItem(
                          icon: Icons.monitor_heart,
                          title: "Monitoring Berkala",
                          text:
                              "Lakukan pemindaian ulang secara berkala untuk memastikan kondisi tetap stabil.",
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // ======== CARA PENANGANAN ========
                    _buildSectionCard(
                      title: "Cara Penanganan",
                      icon: Icons.medical_services_outlined,
                      items: const [
                        _SectionItem(
                          icon: Icons.local_hospital,
                          title: "Konsultasi Medis",
                          text:
                              "Jika hasil menunjukkan tingkat kerusakan tinggi, segera konsultasikan ke dokter spesialis jantung.",
                        ),
                        _SectionItem(
                          icon: Icons.spa,
                          title: "Relaksasi",
                          text:
                              "Cobalah teknik relaksasi seperti meditasi atau pernapasan dalam untuk menurunkan tingkat stres.",
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Timestamp
                    Center(
                      child: Text(
                        "Scan: ${scanDate.toString().substring(0, 16)}",
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),

                    const SizedBox(height: 100), // Space untuk bottom button
                  ],
                ),
              ),
            ),
            // ======== BOTTOM BUTTON ========
            bottomNavigationBar: SafeArea(
              child: Container(
                margin: const EdgeInsets.all(16),
                height: 56,
                child: ElevatedButton(
                  onPressed: () async {
                    // FUNGSI SIMPAN YANG BARU
                    await _saveScanHistory(
                      context: context,
                      imagePath: imagePath,
                      result: result,
                      info: info,
                      scanDate: scanDate,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF113047),
                    foregroundColor: Colors.white,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Simpan Hasil",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          );
        } else {
          return const Scaffold(
            backgroundColor: Color(0xFFFFF8F0),
            body: Center(child: Text("Tidak ada hasil deteksi.")),
          );
        }
      },
    );
  }

  // ======== FUNGSI SIMPAN BARU ========
  Future<void> _saveScanHistory({
    required BuildContext context,
    required String imagePath,
    required String result,
    required Map<String, dynamic> info,
    required DateTime scanDate,
  }) async {
    // Show loading
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF113047)),
        ),
      ),
    );

    try {
      final historyService = ScanHistoryService();
      
      // Create scan history object
      final scanHistory = ScanHistory(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        imagePath: imagePath,
        result: result,
        damage: info['damage'] ?? '-',
        rest: info['rest'] ?? '-',
        desc1: info['desc1'] ?? '',
        desc2: info['desc2'] ?? '',
        scanDate: scanDate,
      );

      // Save to local storage
      final success = await historyService.saveScanHistory(scanHistory);

      // Close loading dialog
      if (context.mounted) {
        Navigator.pop(context);
      }

      if (success) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: const [
                  Icon(Icons.check_circle, color: Colors.white),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      "Hasil scan berhasil disimpan!",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              backgroundColor: const Color(0xFF00AD06),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              duration: const Duration(seconds: 2),
            ),
          );

          // Navigate back to dashboard
          Navigator.pop(context);
        }
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Gagal menyimpan hasil scan"),
              backgroundColor: Color(0xFFE91A18),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      }
    } catch (e) {
      // Close loading dialog
      if (context.mounted) {
        Navigator.pop(context);
      }

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error: $e"),
            backgroundColor: const Color(0xFFE91A18),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  // ======== MAIN RESULT CARD ========
  Widget _buildMainResultCard(String result, Map<String, dynamic> info, String imagePath) {
    Color statusColor;
    IconData statusIcon;

    switch (result) {
      case 'Sehat':
        statusColor = const Color(0xFF00AD06);
        statusIcon = Icons.check_circle;
        break;
      case 'Risiko Kecil':
        statusColor = const Color(0xFFFFB800);
        statusIcon = Icons.warning_amber_rounded;
        break;
      case 'Risiko Menengah':
        statusColor = const Color(0xFFFF6B00);
        statusIcon = Icons.error_outline;
        break;
      case 'Risiko Tinggi':
        statusColor = const Color(0xFFE91A18);
        statusIcon = Icons.dangerous;
        break;
      default:
        statusColor = Colors.grey;
        statusIcon = Icons.help_outline;
    }

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF113047),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header dengan status
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Color(0xFFFBF0D8), width: 1),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    statusIcon,
                    color: statusColor,
                    size: 32,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Kondisi Terdeteksi:",
                        style: TextStyle(
                          color: Color(0xFFFBF0D8),
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        result,
                        style: TextStyle(
                          color: statusColor,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Image preview
          if (imagePath.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.file(
                  File(imagePath),
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
        ],
      ),
    );
  }

  // ======== DETAIL CARD ========
  Widget _buildDetailCard(Map<String, dynamic> info) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF113047),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFFBF0D8),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Ringkasan Detail",
            style: TextStyle(
              color: Color(0xFFFBF0D8),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          // Info rows dengan icon
          _buildInfoRowWithIcon(
            icon: Icons.favorite,
            label: "Kerusakan Jantung",
            value: info['damage'] ?? '-',
          ),
          const SizedBox(height: 12),

          _buildInfoRowWithIcon(
            icon: Icons.bed,
            label: "Rekomendasi Istirahat",
            value: info['rest'] ?? '-',
          ),
          const SizedBox(height: 20),

          // Descriptions
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFFBF0D8).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.info_outline,
                      color: Color(0xFFFBF0D8),
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      "Informasi",
                      style: TextStyle(
                        color: Color(0xFFFBF0D8),
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  info['desc1'] ?? '',
                  style: const TextStyle(
                    color: Color(0xFFFBF0D8),
                    fontSize: 13,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  info['desc2'] ?? '',
                  style: const TextStyle(
                    color: Color(0xFFFBF0D8),
                    fontSize: 13,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRowWithIcon({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: const Color(0xFFFBF0D8),
          size: 20,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: Color(0xFFFBF0D8),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  color: Color(0xFFFBF0D8),
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ======== SECTION CARD ========
  Widget _buildSectionCard({
    required String title,
    required IconData icon,
    required List<_SectionItem> items,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFFBF0D8),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF113047).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    icon,
                    color: const Color(0xFF113047),
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFF113047),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          ...items,
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Future<String> _micropadDetect(String imagePath) async {
    final interpreter = await Interpreter.fromAsset('assets/model/heartsnap_model2.tflite');
    interpreter.allocateTensors();

    print('Input Tensor: ${interpreter.getInputTensors().first.shape}');
    print('Output Tensor: ${interpreter.getOutputTensors().first.shape}');

    try {
      final input = await imagePathToFloat32Tensor(
        imagePath: imagePath,
        inputWidth: 224,
        inputHeight: 224,
      );

      final labels = ['Risiko Kecil', 'Risiko Menengah', 'Risiko Tinggi', 'Sehat'];
      var output = List.generate(1, (_) => List.filled(labels.length, 0.0));

      interpreter.run(input, output);

      double maxValue = output[0].reduce((a, b) => a > b ? a : b);
      int maxIndex = output[0].indexOf(maxValue);

      print('Output: $output');
      print('Prediksi: ${labels[maxIndex]} ($maxValue)');

      if (maxValue < 0.3) {
        return 'tidak terdeteksi';
      }

      return labels[maxIndex];
    } catch (e) {
      print("Error running interpreter: $e");
      rethrow;
    } finally {
      interpreter.close();
    }
  }

  Future<List<List<List<List<double>>>>> imagePathToFloat32Tensor({
    required String imagePath,
    required int inputWidth,
    required int inputHeight,
  }) async {
    final bytes = await File(imagePath).readAsBytes();

    image_dart.Image? image = image_dart.decodeImage(bytes);
    if (image == null) throw Exception("Cannot decode image at $imagePath");

    image_dart.Image resized = image_dart.copyResize(image,
        width: inputWidth, height: inputHeight);

    final listInput = List.generate(
      1,
      (_) => List.generate(
        inputHeight,
        (y) => List.generate(inputWidth, (x) {
          final pixel = resized.getPixel(x, y);
          final r = pixel.r / 255.0;
          final g = pixel.g / 255.0;
          final b = pixel.b / 255.0;
          return [r, g, b];
        }),
      ),
    );

    return listInput;
  }

  Map<String, dynamic> _getResultInfo(String label) {
    switch (label) {
      case 'Risiko Kecil':
        return {
          'damage': '10%-20%',
          'rest': 'Hindari melakukan kegiatan berat, perbanyak istirahat.',
          'desc1': 'Tingkat kerusakan signifikan terdeteksi.',
          'desc2': 'Segera konsultasikan dengan tenaga medis profesional.',
        };
      case 'Risiko Menengah':
        return {
          'damage': '30%-50%',
          'rest': 'Perbanyak istirahat, jangan memporsir kegiatan',
          'desc1': 'Terdapat sedikit tanda kerusakan jantung.',
          'desc2': 'Disarankan beristirahat singkat, konsultasi ke dokter, dan tetap terhidrasi.',
        };
      case 'Risiko Tinggi':
        return {
          'damage': '60%-90%',
          'rest': 'Perbanyak istirahat, jangan memporsir kegiatan',
          'desc1': 'Kondisi menunjukkan adanya tekanan pada fungsi jantung.',
          'desc2': 'Istirahat dan hindari aktivitas berat hingga kondisi pulih, segera datang ke dokter jantung.',
        };
      case 'Sehat':
        return {
          'damage': '0%',
          'rest': 'Tidur Minimal 8 Jam/Hari',
          'desc1': 'Kondisi jantung dalam keadaan baik dan sehat.',
          'desc2': 'Pertahankan pola hidup sehat dan aktivitas fisik teratur.',
        };
      case 'tidak terdeteksi':
        return {
          'damage': '-',
          'rest': '-',
          'desc1': 'Data tidak dapat dikenali.',
          'desc2': 'Coba ulangi proses pemindaian.',
        };
      default:
        return {
          'damage': '-',
          'rest': '-',
          'desc1': 'Data tidak dapat dikenali.',
          'desc2': 'Coba ulangi proses pemindaian.',
        };
    }
  }
}

class _SectionItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String text;
  const _SectionItem({
    required this.icon,
    required this.title,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF00AD06).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF00AD06),
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF00AD06),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  text,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.black87,
                    height: 1.4,
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