import 'package:flutter/material.dart';
import '../constants/colors.dart';

enum ButtonStyle { filled, outlined }

class Button extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const Button.filled({
    Key? key,
    required this.onPressed,
    required this.label,
    this.style = ButtonStyle.filled,
    this.color = AppColors.buttonOn,
    this.selectedColor = AppColors.buttonOn, // Warna saat tombol dipilih
    this.textColor = Colors.white,
    this.isSelected = false, // Tambah properti isSelected
    this.width = double.infinity,
    this.height = 50.0,
    this.borderRadius = 16.0,
    this.icon,
    this.disabled = false,
    this.fontSize = 16.0,
  });

  // ignore: use_key_in_widget_constructors
  const Button.outlined({
    Key? key,
    required this.onPressed,
    required this.label,
    this.style = ButtonStyle.outlined,
    this.color = AppColors.grey,
    this.selectedColor = AppColors.buttonOn, // Warna saat tombol dipilih
    this.textColor = AppColors.black,
    this.isSelected = false, // Tambah properti isSelected
    this.width = double.infinity,
    this.height = 50.0,
    this.borderRadius = 16.0,
    this.icon,
    this.disabled = false,
    this.fontSize = 16.0,
  });

  final Function() onPressed;
  final String label;
  final ButtonStyle style;
  final Color color;
  final Color selectedColor; // Tambah properti selectedColor
  final Color textColor;
  final bool isSelected; // Tambah properti isSelected
  final double width;
  final double height;
  final double borderRadius;
  final Widget? icon;
  final bool disabled;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: style == ButtonStyle.filled
          ? ElevatedButton(
              onPressed: disabled ? null : onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: isSelected
                    ? selectedColor
                    : color, // Gunakan selectedColor jika dipilih
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  icon ?? const SizedBox.shrink(),
                  if (icon != null) const SizedBox(width: 10.0),
                  Text(
                    label,
                    style: TextStyle(
                      color: disabled ? Colors.grey : textColor,
                      fontSize: fontSize,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            )
          : OutlinedButton(
              onPressed: disabled ? null : onPressed,
              style: OutlinedButton.styleFrom(
                backgroundColor: isSelected
                    ? selectedColor
                    : color, // Gunakan selectedColor jika dipilih
                side: const BorderSide(color: Colors.grey),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  icon ?? const SizedBox.shrink(),
                  if (icon != null) const SizedBox(width: 10.0),
                  Text(
                    label,
                    style: TextStyle(
                      color:
                          disabled ? Colors.black.withOpacity(0.5) : textColor,
                      fontSize: fontSize,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
