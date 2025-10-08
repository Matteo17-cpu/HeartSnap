
import 'dart:io';

import 'package:flutter/material.dart';

class DetectionResultPage extends StatelessWidget {
  final String imagePath;
  const DetectionResultPage(this.imagePath, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.file(File(imagePath))
    );
  }
}