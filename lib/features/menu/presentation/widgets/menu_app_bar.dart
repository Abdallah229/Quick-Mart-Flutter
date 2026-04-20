import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_ordering_system/features/cart/presentation/cubit/cart_cubit.dart';

import '../cubit/menu_cubit.dart';

/// The custom AppBar for the Menu Screen.
///
/// Implements [PreferredSizeWidget] so it can be used natively in a Scaffold.
/// It contains a dynamic shopping cart icon that listens to the [CartCubit]
/// and displays a badge with the total number of items currently in the cart.
class MenuAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;

  const MenuAppBar({super.key, required this.title});

  @override
  State<MenuAppBar> createState() => _MenuAppBarState();
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _MenuAppBarState extends State<MenuAppBar> {
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  Timer? _debounce;
  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _startSearch() {
    setState(() {
      _isSearching = true;
    });
    _focusNode.requestFocus();
  }

  void _stopSearch() {
    setState(() {
      _isSearching = false;
    });
    _searchController.clear();
    _focusNode.unfocus();
    context.read<MenuCubit>().clearSearch();
  }

  void _onSearchChanged(String query) {
    // If the user types another letter, cancel the active timer
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    // start a new 500ms timer.
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (query.trim().isNotEmpty) {
        context.read<MenuCubit>().searchMenu(query.trim());
      } else {
        context.read<MenuCubit>().clearSearch();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (_isSearching) {
      return AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: _stopSearch,
        ),
        title: TextField(
          controller: _searchController,
          focusNode: _focusNode,
          onChanged: _onSearchChanged,
          style: theme.textTheme.bodyLarge,
          decoration: InputDecoration(
            hintText: 'Search for products...',
            border: InputBorder.none,
            hintStyle: TextStyle(color: theme.colorScheme.onSurfaceVariant),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              // If text is empty, close search. If not, just clear the text.
              if (_searchController.text.isEmpty) {
                _stopSearch();
              } else {
                _searchController.clear();
                _onSearchChanged('');
              }
            },
            icon: const Icon(Icons.close),
          ),
        ],
      );
    }
    return AppBar(
      title: Text(
        widget.title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: IconButton(
            onPressed: _startSearch,
            icon: const Icon(Icons.search),
          ),
        ),
      ],
    );
  }
}
