import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';

class ScanHistory {
  final String id;
  final String imagePath;
  final String result;
  final String damage;
  final String rest;
  final String desc1;
  final String desc2;
  final DateTime scanDate;
  final String? notes;

  ScanHistory({
    required this.id,
    required this.imagePath,
    required this.result,
    required this.damage,
    required this.rest,
    required this.desc1,
    required this.desc2,
    required this.scanDate,
    this.notes,
  });

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'imagePath': imagePath,
      'result': result,
      'damage': damage,
      'rest': rest,
      'desc1': desc1,
      'desc2': desc2,
      'scanDate': scanDate.toIso8601String(),
      'notes': notes,
    };
  }

  // Convert from JSON
  factory ScanHistory.fromJson(Map<String, dynamic> json) {
    return ScanHistory(
      id: json['id'],
      imagePath: json['imagePath'],
      result: json['result'],
      damage: json['damage'],
      rest: json['rest'],
      desc1: json['desc1'],
      desc2: json['desc2'],
      scanDate: DateTime.parse(json['scanDate']),
      notes: json['notes'],
    );
  }

  // Get status color
  Color getStatusColor() {
    switch (result) {
      case 'Sehat':
        return const Color(0xFF00AD06);
      case 'Risiko Kecil':
        return const Color(0xFFFFB800);
      case 'Risiko Menengah':
        return const Color(0xFFFF6B00);
      case 'Risiko Tinggi':
        return const Color(0xFFE91A18);
      default:
        return Colors.grey;
    }
  }

  // Get status icon
  IconData getStatusIcon() {
    switch (result) {
      case 'Sehat':
        return Icons.check_circle;
      case 'Risiko Kecil':
        return Icons.warning_amber_rounded;
      case 'Risiko Menengah':
        return Icons.error_outline;
      case 'Risiko Tinggi':
        return Icons.dangerous;
      default:
        return Icons.help_outline;
    }
  }
}