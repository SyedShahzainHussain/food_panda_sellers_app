import 'package:driver_panda_app/firebase_options.dart';
import 'package:driver_panda_app/global/global.dart';
import 'package:driver_panda_app/view/my_splash_screen/my_splash_screen.dart';
import 'package:driver_panda_app/viewModel/auth_view_model/sign_up_view_model.dart';
import 'package:driver_panda_app/viewModel/auth_view_model/login_view_model.dart';
import 'package:driver_panda_app/viewModel/upload_item/upload_item_view_model.dart';
import 'package:driver_panda_app/viewModel/upload_menu/upload_menu.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'viewModel/order_viewModel/order_view_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SignUpViewModel()),
        ChangeNotifierProvider(create: (context) => LoginViewModel()),
        ChangeNotifierProvider(create: (context) => UploadViewModel()),
        ChangeNotifierProvider(create: (context) => UploadItemViewModel()),
        ChangeNotifierProvider(create: (context) => OrderViewModel()),
      ],
      child: MaterialApp(
        title: 'Sellers App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
 