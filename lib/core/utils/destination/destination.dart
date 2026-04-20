import 'package:flutter/material.dart';

class Destination {
  final IconData icon;
  final String label;
  final IconData activeIcon;

  const Destination({
    required this.icon,
    required this.label,
    required this.activeIcon,
  });
}