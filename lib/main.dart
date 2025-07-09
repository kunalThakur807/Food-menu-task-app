import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:task_app/bindings/bindings.dart';
import 'package:task_app/route/route_constants.dart';
import 'package:task_app/route/router.dart' as router;
import 'package:task_app/services/notification_service.dart';
import 'package:task_app/services/theme_service.dart';
import 'package:task_app/theme/themedata.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init(); // Initialize local storage
  await NotificationService().init(); // initialize notification service
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Food Menu Task',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeService().theme,
      onGenerateRoute: router.generateRoute,
      initialRoute: Routes.foodMenuScreenRoute,
      initialBinding: InitialScreenBindings(),
    );
  }
}
