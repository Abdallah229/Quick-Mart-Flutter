import 'package:flutter/material.dart';

class CartQuantityUpdatingButton extends StatelessWidget {
  final VoidCallback onPress;
  final IconData icon;
  final Color? iconColor;

  const CartQuantityUpdatingButton({
    super.key,
    required this.onPress,
    required this.icon,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return IconButton(
      onPressed: onPress,
      icon: Icon(icon, color: iconColor ?? theme.colorScheme.primary),
    );
  }
}