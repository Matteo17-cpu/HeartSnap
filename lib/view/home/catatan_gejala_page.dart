// ==========================================
// catatan_gejala_page.dart
// ==========================================
import 'package:flutter/material.dart';
import 'package:heartsnap/common/color_extension.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CatatanGejalaPage extends StatefulWidget {
  const CatatanGejalaPage({super.key});

  @override
  State<CatatanGejalaPage> createState() => _CatatanGejalaPageState();
}

class _CatatanGejalaPageState extends State<CatatanGejalaPage> {
  List<GejalaEntry> _gejalaList = [];
  bool _isLoading = true;

  // Daftar gejala umum penyakit jantung
  final List<GejalaItem> _availableGejala = [
    GejalaItem(
      name: 'Nyeri Dada',
      icon: Icons.favorite_border,
      severity: 'Tinggi',
      color: const Color(0xFFE91A18),
    ),
    GejalaItem(
      name: 'Sesak Napas',
      icon: Icons.air,
      severity: 'Tinggi',
      color: const Color(0xFFFF6B00),
    ),
    GejalaItem(
      name: 'Lelah Berlebihan',
      icon: Icons.battery_alert,
      severity: 'Sedang',
      color: const Color(0xFFFFB800),
    ),
    GejalaItem(
      name: 'Jantung Berdebar',
      icon: Icons.favorite,
      severity: 'Sedang',
      color: const Color(0xFFFF6B00),
    ),
    GejalaItem(
      name: 'Pusing',
      icon: Icons.psychology_alt,
      severity: 'Ringan',
      color: const Color(0xFFFFB800),
    ),
    GejalaItem(
      name: 'Mual',
      icon: Icons.sick,
      severity: 'Ringan',
      color: const Color(0xFFFFB800),
    ),
    GejalaItem(
      name: 'Keringat Dingin',
      icon: Icons.water_drop,
      severity: 'Sedang',
      color: const Color(0xFFFF6B00),
    ),
    GejalaItem(
      name: 'Tidak Ada Keluhan',
      icon: Icons.check_circle,
      severity: 'Sehat',
      color: const Color(0xFF00AD06),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _loadGejala();
  }

  Future<void> _loadGejala() async {
    setState(() => _isLoading = true);
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonList = prefs.getStringList('gejala_list') ?? [];
      
      setState(() {
        _gejalaList = jsonList
            .map((json) => GejalaEntry.fromJson(jsonDecode(json)))
            .toList();
        _isLoading = false;
      });
    } catch (e) {
      print('Error loading gejala: $e');
      setState(() => _isLoading = false);
    }
  }

  Future<void> _saveGejala(List<String> selectedGejala, String notes, int intensitas) async {
    try {
      final entry = GejalaEntry(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        gejalaList: selectedGejala,
        notes: notes,
        intensitas: intensitas,
        timestamp: DateTime.now(),
      );

      _gejalaList.insert(0, entry);

      final prefs = await SharedPreferences.getInstance();
      final jsonList = _gejalaList.map((g) => jsonEncode(g.toJson())).toList();
      await prefs.setStringList('gejala_list', jsonList);

      _loadGejala();
    } catch (e) {
      print('Error saving gejala: $e');
    }
  }

  Future<void> _deleteGejala(String id) async {
    try {
      _gejalaList.removeWhere((g) => g.id == id);

      final prefs = await SharedPreferences.getInstance();
      final jsonList = _gejalaList.map((g) => jsonEncode(g.toJson())).toList();
      await prefs.setStringList('gejala_list', jsonList);

      _loadGejala();
    } catch (e) {
      print('Error deleting gejala: $e');
    }
  }

  void _showAddGejalaDialog() {
    final selectedGejala = <String>[];
    final notesController = TextEditingController();
    int intensitas = 3;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Container(
          height: MediaQuery.of(context).size.height * 0.85,
          decoration: const BoxDecoration(
            color: Color(0xFFFFF8F0),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
          child: Column(
            children: [
              // Handle bar
              Container(
                margin: const EdgeInsets.only(top: 12),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              // Header
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: TColor.primaryColor1.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.note_add,
                        color: TColor.primaryColor1,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'Catat Gejala Hari Ini',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Pilih Gejala
                      const Text(
                        'Pilih Gejala yang Dirasakan:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),

                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: _availableGejala.map((gejala) {
                          final isSelected = selectedGejala.contains(gejala.name);
                          return FilterChip(
                            selected: isSelected,
                            label: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  gejala.icon,
                                  size: 16,
                                  color: isSelected ? Colors.white : gejala.color,
                                ),
                                const SizedBox(width: 6),
                                Text(gejala.name),
                              ],
                            ),
                            backgroundColor: Colors.white,
                            selectedColor: gejala.color,
                            labelStyle: TextStyle(
                              color: isSelected ? Colors.white : Colors.black87,
                              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                            ),
                            onSelected: (selected) {
                              setModalState(() {
                                if (gejala.name == 'Tidak Ada Keluhan') {
                                  selectedGejala.clear();
                                  if (selected) {
                                    selectedGejala.add(gejala.name);
                                  }
                                } else {
                                  selectedGejala.remove('Tidak Ada Keluhan');
                                  if (selected) {
                                    selectedGejala.add(gejala.name);
                                  } else {
                                    selectedGejala.remove(gejala.name);
                                  }
                                }
                              });
                            },
                          );
                        }).toList(),
                      ),

                      const SizedBox(height: 24),

                      // Intensitas (hanya jika ada gejala)
                      if (selectedGejala.isNotEmpty && !selectedGejala.contains('Tidak Ada Keluhan')) ...[
                        const Text(
                          'Tingkat Intensitas:',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Colors.grey[300]!,
                            ),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('Ringan'),
                                  Text(
                                    intensitas.toString(),
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: _getIntensityColor(intensitas),
                                    ),
                                  ),
                                  const Text('Parah'),
                                ],
                              ),
                              Slider(
                                value: intensitas.toDouble(),
                                min: 1,
                                max: 5,
                                divisions: 4,
                                activeColor: _getIntensityColor(intensitas),
                                onChanged: (value) {
                                  setModalState(() {
                                    intensitas = value.toInt();
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],

                      // Catatan Tambahan
                      const Text(
                        'Catatan Tambahan (Opsional):',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: notesController,
                        maxLines: 4,
                        decoration: InputDecoration(
                          hintText: 'Contoh: Nyeri terasa di dada kiri, berlangsung 5 menit...',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.grey[300]!),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.grey[300]!),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),

              // Bottom Button
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, -4),
                    ),
                  ],
                ),
                child: SafeArea(
                  child: ElevatedButton(
                    onPressed: selectedGejala.isEmpty
                        ? null
                        : () async {
                            await _saveGejala(
                              selectedGejala,
                              notesController.text,
                              intensitas,
                            );
                            if (context.mounted) {
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Gejala berhasil dicatat'),
                                  backgroundColor: Color(0xFF00AD06),
                                ),
                              );
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: TColor.primaryColor1,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 56),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Simpan Catatan',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getIntensityColor(int intensity) {
    switch (intensity) {
      case 1:
        return const Color(0xFF00AD06);
      case 2:
        return const Color(0xFFFFB800);
      case 3:
        return const Color(0xFFFF9800);
      case 4:
        return const Color(0xFFFF6B00);
      case 5:
        return const Color(0xFFE91A18);
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
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
          "Catatan Gejala",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF113047)),
              ),
            )
          : _gejalaList.isEmpty
              ? _buildEmptyState()
              : RefreshIndicator(
                  onRefresh: _loadGejala,
                  color: const Color(0xFF113047),
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _gejalaList.length,
                    itemBuilder: (context, index) {
                      final gejala = _gejalaList[index];
                      return _buildGejalaCard(gejala);
                    },
                  ),
                ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddGejalaDialog,
        backgroundColor: TColor.primaryColor1,
        icon: const Icon(Icons.add),
        label: const Text(
          'Catat Gejala',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.note_add_outlined,
            size: 100,
            color: Colors.grey[300],
          ),
          const SizedBox(height: 16),
          Text(
            'Belum ada catatan gejala',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Catat gejala yang Anda rasakan hari ini',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: _showAddGejalaDialog,
            icon: const Icon(Icons.add),
            label: const Text('Catat Gejala Pertama'),
            style: ElevatedButton.styleFrom(
              backgroundColor: TColor.primaryColor1,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGejalaCard(GejalaEntry gejala) {
    final hasSymptoms = !gejala.gejalaList.contains('Tidak Ada Keluhan');

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: hasSymptoms
                  ? _getIntensityColor(gejala.intensitas).withOpacity(0.1)
                  : const Color(0xFF00AD06).withOpacity(0.1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: hasSymptoms
                        ? _getIntensityColor(gejala.intensitas).withOpacity(0.2)
                        : const Color(0xFF00AD06).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    hasSymptoms ? Icons.warning_amber : Icons.check_circle,
                    color: hasSymptoms
                        ? _getIntensityColor(gejala.intensitas)
                        : const Color(0xFF00AD06),
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _formatDate(gejala.timestamp),
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        hasSymptoms ? 'Ada gejala' : 'Tidak ada keluhan',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline, color: Colors.red),
                  onPressed: () async {
                    final confirm = await showDialog<bool>(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Hapus Catatan'),
                        content: const Text('Yakin ingin menghapus catatan ini?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context, false),
                            child: const Text('Batal'),
                          ),
                          ElevatedButton(
                            onPressed: () => Navigator.pop(context, true),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                            ),
                            child: const Text('Hapus'),
                          ),
                        ],
                      ),
                    );
                    if (confirm == true) {
                      _deleteGejala(gejala.id);
                    }
                  },
                ),
              ],
            ),
          ),

          // Content
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Gejala List
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: gejala.gejalaList.map((g) {
                    final gejalaItem = _availableGejala.firstWhere(
                      (item) => item.name == g,
                      orElse: () => GejalaItem(
                        name: g,
                        icon: Icons.circle,
                        severity: 'Unknown',
                        color: Colors.grey,
                      ),
                    );
                    return Chip(
                      avatar: Icon(gejalaItem.icon, size: 16, color: gejalaItem.color),
                      label: Text(g),
                      backgroundColor: gejalaItem.color.withOpacity(0.1),
                      side: BorderSide.none,
                    );
                  }).toList(),
                ),

                // Intensitas bar
                if (hasSymptoms) ...[
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Text(
                        'Intensitas: ',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Expanded(
                        child: LinearProgressIndicator(
                          value: gejala.intensitas / 5,
                          backgroundColor: Colors.grey[200],
                          valueColor: AlwaysStoppedAnimation(
                            _getIntensityColor(gejala.intensitas),
                          ),
                          minHeight: 8,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${gejala.intensitas}/5',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: _getIntensityColor(gejala.intensitas),
                        ),
                      ),
                    ],
                  ),
                ],

                // Notes
                if (gejala.notes.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      gejala.notes,
                      style: const TextStyle(
                        fontSize: 13,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return 'Hari ini, ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
    } else if (difference.inDays == 1) {
      return 'Kemarin, ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
    } else {
      return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
    }
  }
}

// ==========================================
// MODELS
// ==========================================
class GejalaEntry {
  final String id;
  final List<String> gejalaList;
  final String notes;
  final int intensitas;
  final DateTime timestamp;

  GejalaEntry({
    required this.id,
    required this.gejalaList,
    required this.notes,
    required this.intensitas,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'gejalaList': gejalaList,
      'notes': notes,
      'intensitas': intensitas,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  factory GejalaEntry.fromJson(Map<String, dynamic> json) {
    return GejalaEntry(
      id: json['id'],
      gejalaList: List<String>.from(json['gejalaList']),
      notes: json['notes'],
      intensitas: json['intensitas'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }
}

class GejalaItem {
  final String name;
  final IconData icon;
  final String severity;
  final Color color;

  GejalaItem({
    required this.name,
    required this.icon,
    required this.severity,
    required this.color,
  });
}