import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_mart/core/theming/themes/dark_theme.dart';
import 'package:quick_mart/core/theming/themes/light_theme.dart';
import 'package:quick_mart/features/home/presentation/pages/main_shell_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:quick_mart/core/utils/hive_boxes.dart';
import 'package:quick_mart/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:quick_mart/features/home/presentation/pages/home_screen.dart';
import 'package:quick_mart/injection_container.dart'
    as di; // Aliased for clarity

void main() async {
  // 1. Ensure Flutter's engine is fully initialized before we run async code
  WidgetsFlutterBinding.ensureInitialized();

  // 2. Initialize Hive for local device storage
  await Hive.initFlutter();

  // 3. Open the specific physical boxes on the disk so our Data Sources can use them
  await Hive.openBox<dynamic>(HiveBoxes.menuBoxName);
  await Hive.openBox<dynamic>(HiveBoxes.cartBoxName);
  await Hive.openBox<dynamic>(HiveBoxes.detailedProductsBoxName);

  // 4. Boot up the Dependency Injection Service Locator (get_it)
  await di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 5. We use MultiBlocProvider at the very root of the app.
    // Why? Because the Cart is a "Global State". We want the MenuAppBar,
    // the MenuItems, and the eventual CartScreen to all share the EXACT same cart!
    return MultiBlocProvider(
      providers: [
        BlocProvider<CartCubit>(
          // We immediately call ..getCart() so the app loads the user's saved
          // items from Hive the second they open the app!
          create: (context) => di.sl<CartCubit>()..getCart(),
        ),
      ],
      child: MaterialApp(
        darkTheme: darkTheme,
        title: 'Quick Mart',
        debugShowCheckedModeBanner: false, // Hides the annoying debug banner
        theme: lightTheme,
        home: const MainShellScreen(),
      ),
    );
  }
}
