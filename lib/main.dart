import 'package:clean_getx/routes/app_pages.dart';
import 'package:clean_getx/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'init_binding.dart';

void main() async {
  //WidgetsFlutterBinding.ensureInitialized();
  // await GetStorage.init();
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      useInheritedMediaQuery: true,
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.rightToLeftWithFade,
      initialBinding: InitBinding(),
      // getPages: AppPages.pages,
      initialRoute: Routes.initial,
      theme: ThemeData(primarySwatch: Colors.blue),
    );
  }
}
