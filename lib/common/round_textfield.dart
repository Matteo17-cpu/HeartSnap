import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:heartsnap/common/color_extension.dart';


class RoundTextField extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String hitText;
  final String icon;
  final EdgeInsets? margin;
  final bool obsecureText;
  final Widget? rightIcon;
  final bool readOnly;
  final VoidCallback? onTap;
  final List<TextInputFormatter>? inputFormatters;

  const RoundTextField({
    super.key,
    required this.hitText,
    required this.icon,
    this.controller,
    this.margin,
    this.keyboardType,
    this.obsecureText = false,
    this.rightIcon,
    this.readOnly = false,
    this.onTap,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: BoxDecoration(
        color: TColor.lightGray,
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        controller: controller,
        obscureText: obsecureText,
        // ✅ Fix: gunakan keyboardType yang dikirim atau default ke text
        keyboardType: keyboardType ?? TextInputType.text,
        readOnly: readOnly,
        onTap: onTap,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          hintText: hitText,
          suffixIcon: rightIcon,
          prefixIcon: Container(
            alignment: Alignment.center,
            width: 20,
            height: 20,
            child: Image.asset(
              icon,
              width: 20,
              height: 20,
              fit: BoxFit.contain,
              color: TColor.gray,
            ),
          ),
          hintStyle: TextStyle(color: TColor.gray, fontSize: 12),
        ),
      ),
    );
  }
}
