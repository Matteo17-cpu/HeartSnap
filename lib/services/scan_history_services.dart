import 'dart:convert';
import 'package:heartsnap/models/scan_history_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScanHistoryService {
  static const String _key = 'scan_history_list';

  // Save scan history
  Future<bool> saveScanHistory(ScanHistory history) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final historyList = await getAllHistory();
      historyList.insert(0, history); // Add to beginning (most recent first)
      
      // Convert to JSON string list
      final jsonList = historyList.map((h) => jsonEncode(h.toJson())).toList();
      return await prefs.setStringList(_key, jsonList);
    } catch (e) {
      print('Error saving history: $e');
      return false;
    }
  }

  // Get all history
  Future<List<ScanHistory>> getAllHistory() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonList = prefs.getStringList(_key) ?? [];
      return jsonList
          .map((json) => ScanHistory.fromJson(jsonDecode(json)))
          .toList();
    } catch (e) {
      print('Error loading history: $e');
      return [];
    }
  }

  // Get history by ID
  Future<ScanHistory?> getHistoryById(String id) async {
    final historyList = await getAllHistory();
    try {
      return historyList.firstWhere((h) => h.id == id);
    } catch (e) {
      return null;
    }
  }

  // Delete history by ID
  Future<bool> deleteHistory(String id) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final historyList = await getAllHistory();
      historyList.removeWhere((h) => h.id == id);
      
      final jsonList = historyList.map((h) => jsonEncode(h.toJson())).toList();
      return await prefs.setStringList(_key, jsonList);
    } catch (e) {
      print('Error deleting history: $e');
      return false;
    }
  }

  // Clear all history
  Future<bool> clearAllHistory() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return await prefs.remove(_key);
    } catch (e) {
      print('Error clearing history: $e');
      return false;
    }
  }

  // Get latest history
  Future<ScanHistory?> getLatestHistory() async {
    final historyList = await getAllHistory();
    return historyList.isEmpty ? null : historyList.first;
  }

  // Get history count for current month
  Future<int> getMonthlyScansCount({int? month, int? year}) async {
    try {
      final now = DateTime.now();
      final targetMonth = month ?? now.month;
      final targetYear = year ?? now.year;
      
      final historyList = await getAllHistory();
      return historyList.where((scan) {
        return scan.scanDate.month == targetMonth && 
               scan.scanDate.year == targetYear;
      }).length;
    } catch (e) {
      print('Error getting monthly scans count: $e');
      return 0;
    }
  }

  // Get scans by date range
  Future<List<ScanHistory>> getScansByDateRange(
    DateTime startDate, 
    DateTime endDate,
  ) async {
    try {
      final historyList = await getAllHistory();
      return historyList.where((scan) {
        return scan.scanDate.isAfter(startDate) && 
               scan.scanDate.isBefore(endDate.add(const Duration(days: 1)));
      }).toList();
    } catch (e) {
      print('Error getting scans by date range: $e');
      return [];
    }
  }

  // Get scans by result type
  Future<List<ScanHistory>> getScansByResult(String result) async {
    try {
      final historyList = await getAllHistory();
      return historyList.where((scan) => scan.result == result).toList();
    } catch (e) {
      print('Error getting scans by result: $e');
      return [];
    }
  }

  // Update scan history
  Future<bool> updateScanHistory(ScanHistory updatedScan) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final historyList = await getAllHistory();
      
      // Find index of scan to update
      final index = historyList.indexWhere((h) => h.id == updatedScan.id);
      if (index != -1) {
        historyList[index] = updatedScan;
        final jsonList = historyList.map((h) => jsonEncode(h.toJson())).toList();
        return await prefs.setStringList(_key, jsonList);
      }
      return false;
    } catch (e) {
      print('Error updating scan history: $e');
      return false;
    }
  }

  // Get statistics
  Future<Map<String, dynamic>> getStatistics() async {
    try {
      final historyList = await getAllHistory();
      
      if (historyList.isEmpty) {
        return {
          'total': 0,
          'sehat': 0,
          'risikoKecil': 0,
          'risikoMenengah': 0,
          'risikoTinggi': 0,
        };
      }

      return {
        'total': historyList.length,
        'sehat': historyList.where((s) => s.result == 'Sehat').length,
        'risikoKecil': historyList.where((s) => s.result == 'Risiko Kecil').length,
        'risikoMenengah': historyList.where((s) => s.result == 'Risiko Menengah').length,
        'risikoTinggi': historyList.where((s) => s.result == 'Risiko Tinggi').length,
      };
    } catch (e) {
      print('Error getting statistics: $e');
      return {
        'total': 0,
        'sehat': 0,
        'risikoKecil': 0,
        'risikoMenengah': 0,
        'risikoTinggi': 0,
      };
    }
  }
}