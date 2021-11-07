import 'package:flutter/material.dart';

class BottomNavItem {
  static BottomNavigationBarItem build(String label, String assetImgPath, bool isSelected) {
    return BottomNavigationBarItem(
        icon: ImageIcon(
            AssetImage(assetImgPath),
            color: isSelected ? Colors.white : Colors.white54,
            size: 24,
        ),
        label: label,
      );
  }
}