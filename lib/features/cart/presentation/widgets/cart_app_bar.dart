import 'package:flutter/material.dart';

class CartAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CartAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(title: const Text('Your Cart'));
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
