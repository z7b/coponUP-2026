import 'package:coppon_3pp/Binding/binding.dart';
import 'package:coppon_3pp/DartMode/theme_service.dart';
import 'package:coppon_3pp/PageFile/MyHomePage/MyHomePage.dart';
import 'package:coppon_3pp/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import "package:flutter/material.dart";
import 'package:flutter/services.dart' show DeviceOrientation, SystemChrome, TextDirection;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

Future<void> main() async{
  await GetStorage.init();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
     options: DefaultFirebaseOptions.currentPlatform,
  );
  ///debugPaintSizeEnabled = false; // تمكين تصحيح حجم الويدجتات

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'كوبون توت',
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
      initialBinding: Binding(),
      locale: Locale('ar', 'AE'), // تعيين اللغة العربية
      textDirection: TextDirection.rtl, // تعيين اتجاه النص من اليمين لليسار
      theme: ThemeService().lightTheme,

      darkTheme: ThemeService().darkTheme,

      themeMode: ThemeService().getThemeMode(),
    );
  }
}


