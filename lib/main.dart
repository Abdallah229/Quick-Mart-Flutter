import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_ordering_system/features/menu/presentation/pages/main_shell_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:food_ordering_system/core/utils/hive_boxes.dart';
import 'package:food_ordering_system/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:food_ordering_system/features/menu/presentation/pages/menu_screen.dart';
import 'package:food_ordering_system/injection_container.dart' as di; // Aliased for clarity

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
        title: 'Food Ordering App',
        debugShowCheckedModeBanner: false, // Hides the annoying debug banner
        theme: ThemeData(
          // Material 3 color seed makes the whole app look cohesive instantly
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
          useMaterial3: true,
        ),
        home: const MainShellScreen(),
      ),
    );
  }
}