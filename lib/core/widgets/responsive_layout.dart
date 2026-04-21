import 'package:flutter/material.dart';

/// A structural widget that renders different layouts based on screen width.
class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;
  final Widget? desktop;

  const ResponsiveLayout({
    super.key,
    required this.mobile,
    required this.tablet,
    this.desktop,
  });

  // Standard Material Design Breakpoints
  static bool isMobile(BuildContext context) => MediaQuery.sizeOf(context).width < 600;
  static bool isTablet(BuildContext context) => MediaQuery.sizeOf(context).width >= 600 && MediaQuery.sizeOf(context).width < 1024;
  static bool isDesktop(BuildContext context) => MediaQuery.sizeOf(context).width >= 1024;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width >= 1024 && desktop != null) {
      return desktop!;
    } else if (width >= 600) {
      return tablet;
    } else {
      return mobile;
    }
  }
}